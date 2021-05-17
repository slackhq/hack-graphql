namespace Slack\GraphQL\Types;

/**
 * Named type is any non-wrapping type.
 *
 * These are singletons. Get an instance using ::nullable() or ::nonNullable(), then call ->nullableListOf() or
 * ->nonNullableListOf() to get a list, list of lists, etc. of this type.
 *
 * @see https://spec.graphql.org/draft/#sec-Wrapping-Types
 */
<<__ConsistentConstruct>>
abstract class NamedInputType extends InputType<this::THackType> implements \Slack\GraphQL\Introspection\__Type {

    <<__Enforceable>>
    abstract const type THackType as nonnull;
    abstract const string NAME;

    final private function __construct() {}

    <<__Override>>
    final public function getName(): string {
        return static::NAME;
    }

    <<__Override>>
    final public function unwrapType(): NamedInputType {
        return $this;
    }

    <<__Override>>
    final protected function assertValidVariableValue(mixed $value): this::THackType {
        return $value as this::THackType;
    }

    /**
     * Use these to get the singleton instance of this type.
     */
    <<__MemoizeLSB>>
    final public static function nonNullable(): this {
        return new static();
    }

    <<__MemoizeLSB>>
    final public static function nullable(): NullableInputType<this::THackType> {
        return new NullableInputType(static::nonNullable());
    }
}
