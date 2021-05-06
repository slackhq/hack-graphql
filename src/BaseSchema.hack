namespace Slack\GraphQL;

abstract class BaseSchema {
    abstract public static function resolveField(
        \Graphpinator\Parser\Field\Field $field,
        mixed $parent,
    ): Awaitable<mixed>;
}
