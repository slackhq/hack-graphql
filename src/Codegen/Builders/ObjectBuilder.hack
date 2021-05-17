namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{Vec, Keyset};
use type Facebook\HackCodegen\{CodegenClass, CodegenMethod, HackBuilderValues, HackCodegenFactory};


/**
 * Builder for GraphQL objects and interfaces.
 *
 * The annotated Hack type should be either a class, interface, or shape.
 */
// TODO: It probably makes sense to have a separate builder for interfaces.
final class ObjectBuilder<TField as IFieldBuilder>
    extends OutputTypeBuilder<\Slack\GraphQL\__Private\CompositeType>
    implements ITypeWithFieldsBuilder {
    const classname<\Slack\GraphQL\Types\ObjectType> SUPERCLASS = \Slack\GraphQL\Types\ObjectType::class;

    public function __construct(
        \Slack\GraphQL\__Private\CompositeType $type_info,
        string $hack_type,
        protected vec<TField> $fields,
    ) {
        parent::__construct($type_info, $hack_type);
    }

    final public static function fromTypeAlias<T>(
        \Slack\GraphQL\ObjectType $type_info,
        \ReflectionTypeAlias $type_alias,
    ): ObjectBuilder<ShapeFieldBuilder<T>> {
        $ts = $type_alias->getResolvedTypeStructure();
        invariant(
            $ts['kind'] === \HH\TypeStructureKind::OF_SHAPE && !idx($ts, 'nullable', false),
            'Output objects can only be generated from type aliases of a non-nullable shape type, got %s.',
            TypeStructureKind::getNames()[$ts['kind']],
        );
        return new ObjectBuilder(
            $type_info,
            $type_alias->getName(),
            Vec\map_with_key($ts['fields'], ($name, $ts) ==> new ShapeFieldBuilder($name, $ts)),
        );
    }

    public function build(HackCodegenFactory $cg): CodegenClass {
        return parent::build($cg)
            ->addMethod($this->generateGetFieldDefinition($cg));
    }

    private function generateGetFieldDefinition(HackCodegenFactory $cg): CodegenMethod {
        $method = $cg->codegenMethod('getFieldDefinition')
            ->setPublic()
            ->setReturnType('GraphQL\\IFieldDefinition<this::THackType>')
            ->addParameter('string $field_name');

        $hb = hb($cg);
        $hb->startSwitch('$field_name')
            ->addCaseBlocks(
                $this->fields,
                ($field, $hb) ==> {
                    $field->addGetFieldDefinitionCase($hb);
                },
            )
            ->addDefault()
            ->addLine("throw new \Exception('Unknown field: '.\$field_name);")
            ->endDefault()
            ->endSwitch();

        $method->setBody($hb->getCode());

        return $method;
    }

    final public function getFieldNames(): keyset<string> {
        return Keyset\map($this->fields, $field ==> $field->getName());
    }
}
