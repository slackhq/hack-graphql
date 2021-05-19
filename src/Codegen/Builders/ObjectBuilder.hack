namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\Vec;

final class ObjectBuilder<TField as IFieldBuilder> extends CompositeBuilder<TField> {
    const classname<\Slack\GraphQL\Types\ObjectType> SUPERCLASS = \Slack\GraphQL\Types\ObjectType::class;

    public static function fromTypeAlias<T>(
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
}
