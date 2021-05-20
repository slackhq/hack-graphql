namespace Slack\GraphQL\Types;

interface INamedInputType extends INonNullableInputTypeFor<this::THackType> {
    require extends NamedType;
    public static function nullableI(): NullableInputType<this::THackType>;
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
trait TNamedInputType implements INamedInputType {
    use TInputType<this::THackType>;

    <<__Enforceable>>
    abstract const type THackType as nonnull;

    <<__Override>>
    final public function assertValidVariableValue(mixed $value): this::THackType {
        return $value as this::THackType;
    }

    /**
     * Use these to get the singleton instance of this type.
     */
    <<__MemoizeLSB>>
    final public static function nullableI(): NullableInputType<this::THackType> {
        return new NullableInputType(static::nonNullable());
    }

    <<__Override>>
    public function nullableForIntrospection(): INullableType {
        return static::nullableI();
    }
}
