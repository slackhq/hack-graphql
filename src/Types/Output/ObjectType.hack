namespace Slack\GraphQL\Types;

abstract class ObjectType extends NamedOutputType {

    abstract public static function resolveField(
        string $field_name,
        this::THackType $resolved_parent,
        dict<string, \Graphpinator\Parser\Value\ArgumentValue> $args,
        \Slack\GraphQL\__Private\Variables $vars,
    ): Awaitable<mixed>;

    abstract public static function resolveType(string $field_name): BaseType;
}
