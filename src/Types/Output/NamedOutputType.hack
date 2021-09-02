


namespace Slack\GraphQL\Types;

/**
 * Named type is any non-wrapping type.
 *
 * These are singletons. Get an instance using ::nullableOutput() or ::nonNullable(), then call ->nullableOutputListOf()
 * or ->nonNullableOutputListOf() to get a list, list of lists, etc. of this type.
 *
 * @see https://spec.graphql.org/draft/#sec-Wrapping-Types
 */
interface INamedOutputType extends INonNullableOutputTypeFor<this::THackType, this::TResolved> {
    require extends NamedType;
    abstract const type TResolved;
    public static function nullableOutput(): NullableOutputType<this::THackType, this::TResolved>;
}

<<__ConsistentConstruct>>
trait TNamedOutputType implements INamedOutputType {
    use TOutputType<this::THackType, this::TResolved>;

    <<__MemoizeLSB>>
    final public static function nullableOutput(): NullableOutputType<this::THackType, this::TResolved> {
        return new NullableOutputType(static::nonNullable());
    }

    <<__Override>>
    public function nullableForIntrospection(): INullableType {
        return static::nullableOutput();
    }
}
