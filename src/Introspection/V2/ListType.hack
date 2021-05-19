namespace Slack\GraphQL\Introspection\V2;

use namespace HH\Lib\Vec;

final class ListType<T as __Type> extends __Type {
    public function __construct(private T $inner_type) {}

    <<__Override>>
    public function getKind(): __TypeKind {
        return __TypeKind::LIST;
    }

    <<__Override>>
    public function getOfType(): T {
        return $this->inner_type;
    }
}
