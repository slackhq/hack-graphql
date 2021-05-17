namespace Slack\GraphQL\Types;

use namespace HH\Lib\C;
use namespace Graphpinator\Parser\Value;
use namespace Slack\GraphQL;


abstract class EnumInputType extends NamedInputType {

    <<__Enforceable>>
    abstract const type THackType as arraykey;
    abstract const \HH\enumname<this::THackType> HACK_ENUM;

    <<__Override>>
    public function coerceValue(mixed $value): this::THackType {
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

    <<__Override>>
    final public function coerceNonVariableNode(
        Value\Value $node,
        dict<string, mixed> $variable_values,
    ): this::THackType {
        if (!$node is Value\EnumLiteral) {
            throw new GraphQL\UserFacingError('Expected an enum literal, got %s', \get_class($node));
        }
        $enum = static::HACK_ENUM;
        GraphQL\assert(
            C\contains_key($enum::getValues(), $node->getRawValue()),
            'Expected a valid value for %s, got "%s"',
            static::NAME,
            $node->getRawValue(),
        );
        return $enum::getValues()[$node->getRawValue()];
    }

}
