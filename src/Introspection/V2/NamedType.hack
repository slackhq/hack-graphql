namespace Slack\GraphQL\Introspection\V2;

<<__ConsistentConstruct>>
abstract class NamedType extends __Type {
    abstract const string NAME;
    abstract const ?string DESCRIPTION;

    <<__Override>>
    public function getName(): string {
        return static::NAME;
    }

    <<__Override>>
    public function getDescription(): ?string {
        return static::DESCRIPTION;
    }

    <<__MemoizeLSB>>
    public static function nonNullable(): NonNullType<this> {
        return new NonNullType(new static());
    }

    <<__MemoizeLSB>>
    public static function nullable(): this {
        return new static();
    }

    public function nullableListOf(): ListType<this> {
        return new ListType($this);
    }

    public function nonNullableListOf(): NonNullType<ListType<this>> {
        return new NonNullType(new ListType($this));
    }
}
