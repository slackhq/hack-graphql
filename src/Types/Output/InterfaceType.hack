namespace Slack\GraphQL\Types;
use namespace Slack\GraphQL;

abstract class InterfaceType extends ObjectType implements GraphQL\Introspection\IntrospectableInterface {
    <<__Override>>
    final public function getTypeKind(): GraphQL\Introspection\__TypeKind {
        return GraphQL\Introspection\__TypeKind::INTERFACE;
    }

    public function getPossibleTypes(): ?vec<GraphQL\Introspection\IntrospectableType> {
        // TODO: need to return all the types that implement this interface.
        // Should have a static property that we can codegen.
        return vec[];
    }
}
