namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{Vec, Str};
use type Facebook\HackCodegen\{CodegenClass, HackCodegenFactory, CodegenClassConstant, HackBuilderValues};

final class ObjectBuilder<TField as IFieldBuilder> extends CompositeBuilder<TField> {
    const classname<\Slack\GraphQL\Types\ObjectType> SUPERCLASS = \Slack\GraphQL\Types\ObjectType::class;

    <<__Override>>
    public function __construct(
        \Slack\GraphQL\__Private\CompositeType $type_info,
        string $hack_type,
        vec<TField> $fields,
        private keyset<string> $interfaces,
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
        keyset<string> $interfaces,
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
            $interfaces,
        );
    }

    private function generateInterfacesConstant(HackCodegenFactory $cg): CodegenClassConstant {
        $interfaces = keyset[];
        foreach ($this->interfaces as $interface) {
            if (\is_subclass_of($this->hack_type, $interface)) {
                $interfaces[] = Str\format('%s::class', $interface);
            }
        }

        return $cg->codegenClassConstant('INTERFACES')
            ->setType('keyset<classname<Types\InterfaceType>>')
            ->setValue($interfaces, HackBuilderValues::keyset(HackBuilderValues::literal()));
    }
}
