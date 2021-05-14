namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{Keyset, Str};
use type Facebook\HackCodegen\{CodegenClass, CodegenMethod, HackBuilderValues, HackCodegenFactory};


class OutputObjectType implements GeneratableClass {
    public function __construct(
        private \ReflectionTypeAlias $reflection_type_alias,
        private \Slack\GraphQL\ObjectType $object_type,
    ) {}

    public function getInputTypeName(): null {
        return null;
    }

    public function getOutputTypeName(): string {
        return $this->object_type->getType();
    }

    public function generateClass(HackCodegenFactory $cg): CodegenClass {
        $hack_type = $this->reflection_type_alias->getName();

        $class = $cg->codegenClass($this->object_type->getType())
            ->setExtendsf('\%s', \Slack\GraphQL\Types\ObjectType::class);

        $hack_type_constant = $cg->codegenClassConstant('THackType')
            ->setType('type')
            ->setValue('\\'.$this->reflection_type_alias->getName(), HackBuilderValues::literal());

        $class->addConstant($hack_type_constant);
        $class->addConstant(
            $cg->codegenClassConstant('NAME')->setValue($this->object_type->getType(), HackBuilderValues::export()),
        );

        $class->addMethod($this->generateGetFieldDefinition($cg));

        return $class;
    }


    protected function generateGetFieldDefinition(HackCodegenFactory $cg): CodegenMethod {
        $method = $cg->codegenMethod('getFieldDefinition')
            ->setPublic()
            ->setReturnType('GraphQL\\IFieldDefinition<this::THackType>')
            ->addParameter('string $field_name');

        $ts = $this->reflection_type_alias->getResolvedTypeStructure();
        invariant(
            $ts['kind'] === \HH\TypeStructureKind::OF_SHAPE && !idx($ts, 'nullable', false),
            'Output objects can only be generated from type aliases of a non-nullable shape type, got %s.',
            TypeStructureKind::getNames()[$ts['kind']],
        );

        $hb = hb($cg);
        $hb->startSwitch('$field_name')
            ->addCaseBlocks(
                Keyset\keys($ts['fields']),
                ($field_name, $hb) ==> {
                    $name_literal = \var_export($field_name, true);

                    $hb->addCase($name_literal, HackBuilderValues::literal());
                    $hb->addLine('return new GraphQL\\FieldDefinition(')->indent();

                    // Field return type
                    $field_ts = $ts['fields'][$field_name];
                    $type_info = output_type(type_structure_to_type_alias($field_ts), false);
                    $hb->addLinef('%s,', $type_info['type']);

                    $hb->addf(
                        'async ($schema, $parent, $args, $vars) ==> $parent[%s]%s',
                        $name_literal,
                        Shapes::idx($field_ts, 'optional_shape_field', false) ? ' ?? null' : '',
                    );
                    $hb->addLine(',');

                    // End of new GraphQL\FieldDefinition(
                    $hb->unindent()->addLine(');');
                    $hb->unindent();
                },
            )
            ->addDefault()
            ->addLine("throw new \Exception('Unknown field: '.\$field_name);")
            ->endDefault()
            ->endSwitch();

        $method->setBody($hb->getCode());

        return $method;
    }
}
