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
abstract class NamedOutputType
    extends OutputType<this::THackType, this::TCoerced>
    implements GraphQL\Introspection\IntrospectableObject {

    abstract const type THackType;
    abstract const type TCoerced;
    abstract const string NAME;

    <<__Override>>
    final public function getName(): string {
        return static::NAME;
    }

    /**
     * Use these to get the singleton instance of this type.
     */
    <<__MemoizeLSB>>
    final public static function nonNullable(): NonNullableOutputType<this::THackType, this::TCoerced> {
        return new NonNullableOutputType(self::literal());
    }

    <<__MemoizeLSB>>
    final public static function nullable(): NullableOutputType<this::THackType, this::TCoerced> {
        return new NullableOutputType(self::literal());
    }

    <<__MemoizeLSB>>
    final public static function literal(): OutputType<this::THackType, this::TCoerced> {
        return new static();
    }

    public function getFields(bool $include_deprecated = false): ?vec<GraphQL\Introspection\IntrospectableField> {
        return null;
    }

    public function getInterfaces(): ?vec<GraphQL\Introspection\IntrospectableInterface> {
        return null;
    }
}
