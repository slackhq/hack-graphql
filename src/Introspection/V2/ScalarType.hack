namespace Slack\GraphQL\Introspection\V2;

abstract class ScalarType extends NamedType {
    <<__Override>>
    public function getKind(): __TypeKind {
        return __TypeKind::SCALAR;
    }
}
