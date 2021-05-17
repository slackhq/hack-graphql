namespace Slack\GraphQL\Introspection;

use namespace Slack\GraphQL;

final abstract class QueryRootFields {
    <<GraphQL\QueryRootField('__schema', 'Schema introspection')>>
    final public static function getSchema(): ?__Schema {
        // TODO: switch to taking $schema as first param?
        return new \Slack\GraphQL\Test\Generated\Schema();
    }

    <<GraphQL\QueryRootField('__type', 'Type introspection')>>
    final public static function getType(string $name): ?__Type {
        return (new \Slack\GraphQL\Test\Generated\Schema())->getIntrospectionType($name);
    }
}
