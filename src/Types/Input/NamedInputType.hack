namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

/**
 * Named type is any non-wrapping type.
 *
 * These are singletons. Get an instance using ::nullable() or ::nonNullable(), then call ->nullableListOf() or
 * ->nonNullableListOf() to get a list, list of lists, etc. of this type.
 *
 * @see https://spec.graphql.org/draft/#sec-Wrapping-Types
 */
<<__ConsistentConstruct>>
abstract class NamedInputType extends InputType<this::TCoerced> implements GraphQL\Introspection\IntrospectableObject {

    <<__Enforceable>>
    abstract const type TCoerced as nonnull;
    abstract const string NAME;

    final private function __construct() {}

    <<__Override>>
    final public function getName(): string {
        return static::NAME;
    }

    <<__Override>>
    final protected function assertValidVariableValue(mixed $value): this::TCoerced {
        return $value as this::TCoerced;
    }

    /**
     * Use these to get the singleton instance of this type.
     */
    <<__MemoizeLSB>>
    final public static function nonNullable(): NonNullableInputType<this::TCoerced> {
        return new NonNullableInputType(self::literal());
    }

    <<__MemoizeLSB>>
    final public static function nullable(): NullableInputType<this::TCoerced> {
        return new NullableInputType(self::literal());
    }

    <<__MemoizeLSB>>
    final public static function literal(): InputType<this::TCoerced> {
        return new static();
    }

    public function getFields(bool $include_deprecated = false): ?vec<GraphQL\Introspection\IntrospectableField> {
        return null;
    }

    public function getInterfaces(): ?vec<GraphQL\Introspection\IntrospectableInterface> {
        return null;
    }
}
