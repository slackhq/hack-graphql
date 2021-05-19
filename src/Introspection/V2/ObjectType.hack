namespace Slack\GraphQL\Introspection\V2;

use namespace HH\Lib\Vec;

abstract class ObjectType extends NamedType {
    <<__Override>>
    public function getKind(): __TypeKind {
        return __TypeKind::OBJECT;
    }
}
