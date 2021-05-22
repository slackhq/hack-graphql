namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{Vec, Str};
use type Facebook\HackCodegen\{
    CodegenClass,
    HackCodegenFactory,
    CodegenClassConstant,
    HackBuilderValues,
    HackBuilderKeys,
};

final class ObjectBuilder<TField as IFieldBuilder> extends CompositeBuilder<TField> {
    const classname<\Slack\GraphQL\Types\ObjectType> SUPERCLASS = \Slack\GraphQL\Types\ObjectType::class;

    <<__Override>>
    public function __construct(
        \Slack\GraphQL\__Private\CompositeType $type_info,
        string $hack_type,
        vec<TField> $fields,
        private dict<string, string> $hack_class_to_graphql_interface,
    ) {
        parent::__construct($type_info, $hack_type, $fields);
    }

    <<__Override>>
    public function build(HackCodegenFactory $cg): CodegenClass {
        return parent::build($cg)
            ->addConstant($this->generateInterfacesConstant($cg));
    }

    public static function fromTypeAlias<T>(
        \Slack\GraphQL\ObjectType $type_info,
        \ReflectionTypeAlias $type_alias,
        dict<string, string> $hack_class_to_graphql_interface,
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
            $hack_class_to_graphql_interface,
        );
    }

    private function generateInterfacesConstant(HackCodegenFactory $cg): CodegenClassConstant {
        $interfaces = dict[];
        foreach ($this->hack_class_to_graphql_interface as $hack_class => $graphql_type) {
            if (\is_subclass_of($this->hack_type, $hack_class)) {
                $interfaces[$graphql_type] = Str\format('%s::class', $hack_class);
            }
        }

        return $cg->codegenClassConstant('INTERFACES')
            ->setType('dict<string, classname<Types\InterfaceType>>')
            ->setValue($interfaces, HackBuilderValues::dict(HackBuilderKeys::export(), HackBuilderValues::literal()));
    }
}
