
namespace Slack\GraphQL\Types;

use namespace HH\Lib\{Dict, Vec};
use namespace Slack\GraphQL;

abstract class InterfaceType extends CompositeType {
    abstract const keyset<classname<GraphQL\Types\ObjectType>> POSSIBLE_TYPES;

    <<__Override>>
    final public function getKind(): GraphQL\Introspection\__TypeKind {
        return GraphQL\Introspection\__TypeKind::INTERFACE;
    }

    <<__Override>>
    final public function getPossibleTypes(): vec<classname<ObjectType>> {
        return vec(static::POSSIBLE_TYPES);
    }
}
