namespace Slack\GraphQL\Types;

use namespace HH\Lib\C;
use namespace Slack\GraphQL;
use namespace Graphpinator\Parser\Value;

<<__ConsistentConstruct>>
abstract class InputObjectType extends NamedInputType {

    <<__Enforceable>>
    abstract const type THackType as shape(...);
    abstract const keyset<string> FIELD_NAMES;

    <<__Override>>
    public function coerceValue(mixed $value): this::THackType {
        if (!$value is KeyedContainer<_, _>) {
            throw new GraphQL\UserFacingError('Expected an input object (a dict/map), got %s', \gettype($value));
        }
        foreach ($value as $key => $_) {
            GraphQL\assert(
                C\contains_key(static::FIELD_NAMES, $key),
                'Undefined field "%s" on "%s"',
                (string)$key,
                static::NAME,
            );
        }
        return $this->coerceFieldValues($value);
    }

    abstract protected function coerceFieldValues(KeyedContainer<arraykey, mixed> $values): this::THackType;

    <<__Override>>
    protected function coerceNonVariableNode(
        Value\Value $node,
        dict<string, mixed> $variable_values,
    ): this::THackType {
        if (!$node is Value\ObjectVal) {
            throw new GraphQL\UserFacingError('Expected an input object literal, got %s', \get_class($node));
        }
        foreach ($node->getValue() as $key => $_) {
            GraphQL\assert(
                C\contains_key(static::FIELD_NAMES, $key),
                'Undefined field "%s" on "%s"',
                (string)$key,
                static::NAME,
            );
        }
        return $this->coerceFieldNodes($node->getValue(), $variable_values);
    }

    abstract protected function coerceFieldNodes(
        dict<string, Value\Value> $value_nodes,
        dict<string, mixed> $variable_values,
    ): this::THackType;
}
