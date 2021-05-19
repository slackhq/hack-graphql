namespace Slack\GraphQL\Introspection\V2;

abstract class InterfaceType extends ObjectType {
    <<__Override>>
    public function getKind(): __TypeKind {
        return __TypeKind::INTERFACE;
    }

    <<__Override>>
    public function getPossibleTypes(/* include_deprecated */): ?vec<__Type> {
        // TODO
        return null;
    }
}
