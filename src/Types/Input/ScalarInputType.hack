namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

abstract class ScalarInputType extends NamedInputType {
    <<__Override>>
    final public function getKind(): GraphQL\Introspection\__TypeKind {
        return GraphQL\Introspection\__TypeKind::SCALAR;
    }
}
