namespace Slack\GraphQL\Types;
use namespace Slack\GraphQL;

abstract class ScalarInputType extends NamedInputType {

    public function getTypeKind(): GraphQL\Introspection\__TypeKind {
        return GraphQL\Introspection\__TypeKind::SCALAR;
    }

}
