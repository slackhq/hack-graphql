namespace Slack\GraphQL\Types;

use namespace Facebook\{TypeCoerce, TypeAssert};

<<__ConsistentConstruct>>
abstract class InputObjectType<TCoerced as nonnull> extends InputType<TCoerced> {

    abstract const string NAME;
    abstract public function coerceValue(mixed $value): TCoerced;
    abstract public function assertValidVariableValue(mixed $value): TCoerced;

    <<__Override>>
    final public function getName(): string {
        return static::NAME;
    }

    <<__Override>>
    final public function coerceNonVariableNode(
        \Graphpinator\Parser\Value\Value $node,
        dict<string, mixed> $variable_values,
    ): TCoerced {
        return $this->coerceValue($node->getRawValue());
    }

    /**
     * Use these to get the singleton instance of this type.
     */
    <<__MemoizeLSB>>
    final public static function nonNullable(): this {
        return new static();
    }

    <<__MemoizeLSB>>
    final public static function nullable(): \Slack\GraphQL\Types\NullableInputType<TCoerced> {
        return new \Slack\GraphQL\Types\NullableInputType(static::nonNullable());
    }
}
