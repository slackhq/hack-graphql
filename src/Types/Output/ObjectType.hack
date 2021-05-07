namespace Slack\GraphQL\Types;

abstract class ObjectType extends NamedOutputType {

    abstract public static function resolveField(
        string $field_name,
        this::THackType $resolved_parent,
        vec<\Slack\GraphQL\__Private\Argument> $args,
    ): Awaitable<mixed>;

    abstract public static function resolveType(string $field_name): BaseType;
}
