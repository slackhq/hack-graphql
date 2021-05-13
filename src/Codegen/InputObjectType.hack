namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{Keyset, Str};
use type Facebook\HackCodegen\{CodegenClass, CodegenMethod, HackBuilderValues, HackCodegenFactory};

class InputObjectType implements GeneratableClass {
    public function __construct(
        private \ReflectionTypeAlias $reflection_type_alias,
        private \Slack\GraphQL\InputObjectType $input_type,
    ) {}

    public function getType(): string {
        return $this->input_type->getType();
    }

    public function getInputTypeName(): string {
        return $this->input_type->getType();
    }

    public function getOutputTypeName(): null {
        return null;
    }

    public function generateClass(HackCodegenFactory $cg): CodegenClass {
        $hack_type = $this->reflection_type_alias->getName();

        $class = $cg->codegenClass($this->input_type->getType())
            ->setIsFinal()
            ->setExtendsf('\%s', \Slack\GraphQL\Types\InputObjectType::class)
            ->addTypeConstant(
                $cg->codegenTypeConstant('TCoerced')->setValue('\\'.$hack_type, HackBuilderValues::literal()),
            );

        $name_const = $cg
            ->codegenClassConstant('NAME')
            ->setValue($this->input_type->getType(), HackBuilderValues::export());

        $class->addConstant($name_const);

        $ts = $this->reflection_type_alias->getResolvedTypeStructure();
        invariant(
            $ts['kind'] === \HH\TypeStructureKind::OF_SHAPE && !idx($ts, 'nullable', false),
            'Input objects can only be generated from type aliases of a non-nullable shape type, got %s.',
            TypeStructureKind::getNames()[$ts['kind']],
        );

        $class->addConstant(
            $cg->codegenClassConstant('keyset<string> FIELD_NAMES')
                ->setValue(Keyset\keys($ts['fields']), HackBuilderValues::export()),
        );

        // coerceFieldValues() and coerceFieldNodes()
        $values = hb($cg)->addLine('$ret = shape();');
        $nodes = hb($cg)->addLine('$ret = shape();');

        foreach (($ts['fields'] as nonnull) as $field_name => $field_ts) {
            $is_optional = $field_ts['optional_shape_field'] ?? false;
            $is_nullable = $field_ts['nullable'] ?? false;
            invariant(
                $is_optional === $is_nullable,
                'Field "%s" must be both optional and nullable, or neither (GraphQL doesn\'t distinguish between '.
                'optionality and nullability)',
                $field_name,
            );

            $name_literal = \var_export($field_name, true);
            $type = input_type(($is_optional ? '?' : '').self::typeStructureToHackType($field_ts));

            if ($is_optional) {
                $values->startIfBlockf('C\\contains_key($fields, %s)', $name_literal);
                $nodes->startIfBlockf('$this->hasValue(%s, $fields, $vars)', $name_literal);
            }

            $values->addLinef('$ret[%s] = %s->coerceNamedValue(%s, $fields);', $name_literal, $type, $name_literal);
            $nodes
                ->addLinef('$ret[%s] = %s->coerceNamedNode(%s, $fields, $vars);', $name_literal, $type, $name_literal);

            if ($is_optional) {
                $values->endIfBlock();
                $nodes->endIfBlock();
            }
        }

        $values->addReturn('$ret', HackBuilderValues::literal());
        $nodes->addReturn('$ret', HackBuilderValues::literal());

        return $class->addMethods(vec[
            $cg->codegenMethod('coerceFieldValues')
                ->setIsOverride()
                ->addParameter('KeyedContainer<arraykey, mixed> $fields')
                ->setReturnType('this::TCoerced')
                ->setBody($values->getCode()),
            $cg->codegenMethod('coerceFieldNodes')
                ->setIsOverride()
                ->addParameterf('dict<string, \\%s> $fields', \Graphpinator\Parser\Value\Value::class)
                ->addParameter('dict<string, mixed> $vars')
                ->setReturnType('this::TCoerced')
                ->setBody($nodes->getCode()),
        ]);
    }

    private static function typeStructureToHackType<T>(TypeStructure<T> $ts): string {
        $alias = Shapes::idx($ts, 'alias');
        if ($alias is nonnull) {
            return $alias;
        }

        switch ($ts['kind']) {
            case TypeStructureKind::OF_INT:
                return 'HH\int';
            case TypeStructureKind::OF_STRING:
                return 'HH\string';
            case TypeStructureKind::OF_BOOL:
                return 'HH\bool';
            case TypeStructureKind::OF_VEC:
                return Str\format('HH\vec<%s>', self::typeStructureToHackType($ts['generic_types'] as nonnull[0]));
            case TypeStructureKind::OF_ENUM:
            //case TypeStructureKind::OF_UNRESOLVED: // not sure if this is needed
                return $ts['classname'] as nonnull;
            default:
                invariant_violation(
                    'Shape fields %s cannot be used as input object fields.',
                    TypeStructureKind::getNames()[$ts['kind']],
                );
        }
    }
}
