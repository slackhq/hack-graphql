namespace Slack\GraphQL\Introspection\V2;

final class NonNullType<T as __Type> extends __Type {
    public function __construct(private T $inner_type) {}

    <<__Override>>
    public function getKind(): __TypeKind {
        return __TypeKind::NON_NULL;
    }

    <<__Override>>
    public function getOfType(): T {
        return $this->inner_type;
    }

    public function nullableListOf(): ListType<this> {
        return new ListType($this);
    }

    public function nonNullableListOf(): NonNullType<ListType<this>> {
        return new NonNullType(new ListType($this));
    }
}
