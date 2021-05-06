namespace Slack\GraphQL\Types;

abstract class ObjectType extends BaseType {
    abstract public static function resolveField(
        string $field_name,
        this::THackType $resolved_parent,
    ): Awaitable<mixed>;

    abstract public static function resolveType(string $field_name): BaseType;
}
