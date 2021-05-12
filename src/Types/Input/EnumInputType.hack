namespace Slack\GraphQL\Types;

use namespace HH\Lib\C;
use namespace Graphpinator\Parser\Value;
use namespace Slack\GraphQL;


abstract class EnumInputType extends NamedInputType {

    <<__Enforceable>>
    abstract const type TCoerced as arraykey;
    abstract const \HH\enumname<this::TCoerced> HACK_ENUM;

    <<__Override>>
    public function coerceValue(mixed $value): this::TCoerced {
        $enum = static::HACK_ENUM;
        if (!$value is string || !C\contains_key($enum::getValues(), $value)) {
            throw new GraphQL\UserFacingError(
                'Expected a valid value for %s, got %s',
                static::NAME,
                (string)$value
            );
        }
        return $enum::getValues()[$value];
    }

    final protected function assertValidVariableValue(mixed $value): this::TCoerced {
        // TODO: This should just be $value as this::TCoerced, once variables are properly coerced at the beginning
        // of execution. Otherwise we'd try (and fail) to coerce an already-coerced value here.
        $enum = static::HACK_ENUM;
        return $enum::getValues()[$value as string];
    }

    <<__Override>>
    final public function coerceNonVariableNode(
        Value\Value $node,
        dict<string, mixed> $variable_values,
    ): this::TCoerced {
        $value = $node->getRawValue();
        $enum = static::HACK_ENUM;
        if (!$node is Value\EnumLiteral || !$value is string || !C\contains_key($enum::getValues(), $value)) {
            throw new GraphQL\UserFacingError(
                'Expected a valid value for %s, got %s',
                static::NAME,
                \get_class($node)
            );
        }
        return $enum::getValues()[$value];
    }

}
