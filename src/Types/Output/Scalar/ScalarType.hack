namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

abstract class ScalarOutputType extends LeafType {
    public function getTypeKind(): GraphQL\Introspection\__TypeKind {
        return GraphQL\Introspection\__TypeKind::SCALAR;
    }
}
