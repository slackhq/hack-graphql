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
        GraphQL\assert(
            $value is string && C\contains_key($enum::getValues(), $value),
            'Expected a valid value for %s, got %s',
            static::NAME,
            (string)$value
        );
        return $enum::getValues()[$value as string];
    }

    final protected function assertValidVariableValue(mixed $value): this::TCoerced {
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
        GraphQL\assert(
            $node is Value\EnumLiteral && $value is string && C\contains_key($enum::getValues(), $value),
            'Expected a valid value for %s, got %s',
            static::NAME,
            \get_class($node)
        );
        return $enum::getValues()[$value as string];
    }

}