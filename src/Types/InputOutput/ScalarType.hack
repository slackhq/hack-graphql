namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

abstract class ScalarType extends LeafType {
    const type TCoerced = this::THackType;

    <<__Override>>
    final public function getKind(): GraphQL\Introspection\__TypeKind {
        return GraphQL\Introspection\__TypeKind::SCALAR;
    }
}
