namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

trait IntrospectableNonNullableType implements GraphQL\Introspection\__Type {
    require extends BaseType;

    <<__Override>>
    final public function introspect(): GraphQL\Introspection\NonNullableType {
        return new GraphQL\Introspection\NonNullableType($this);
    }

    <<__Override>>
    final public function getOfType(): null {
        return null;
    }
}
