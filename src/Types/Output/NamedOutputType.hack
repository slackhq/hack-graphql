namespace Slack\GraphQL\Types;

interface INamedOutputType extends INonNullableOutputTypeFor<this::THackType, this::TCoerced> {
    require extends NamedType;
    abstract const type TCoerced;
    public static function nullableO(): NullableOutputType<this::THackType, this::TCoerced>;
}

/**
 * Named type is any non-wrapping type.
 *
 * These are singletons. Get an instance using ::nullable() or ::nonNullable(), then call ->nullableListOf() or
 * ->nonNullableListOf() to get a list, list of lists, etc. of this type.
 *
 * @see https://spec.graphql.org/draft/#sec-Wrapping-Types
 */
<<__ConsistentConstruct>>
trait TNamedOutputType implements INamedOutputType {
    use TOutputType<this::THackType, this::TCoerced>;

    <<__MemoizeLSB>>
    final public static function nullableO(): NullableOutputType<this::THackType, this::TCoerced> {
        return new NullableOutputType(static::nonNullable());
    }

    <<__Override>>
    public function nullableForIntrospection(): INullableType {
        return static::nullableO();
    }
}
