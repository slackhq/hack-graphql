namespace Slack\GraphQL\Types;

use namespace HH\Lib\C;
use namespace Slack\GraphQL;
use namespace Graphpinator\Parser\Value;

<<__ConsistentConstruct>>
abstract class InputObjectType extends NamedInputType {

    <<__Enforceable>>
    abstract const type TCoerced as shape(...);
    abstract const keyset<string> FIELD_NAMES;

    <<__Override>>
    public function coerceValue(mixed $value): this::TCoerced {
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

    abstract protected function coerceFieldValues(KeyedContainer<arraykey, mixed> $values): this::TCoerced;

    <<__Override>>
    protected function coerceNonVariableNode(
        Value\Value $node,
        dict<string, mixed> $variable_values,
    ): this::TCoerced {
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
    ): this::TCoerced;

    /**
     * Follows the GraphQL spec rules for whether a field should be included in the coerced shape -- either a literal
     * value was provided, or the value is a variable reference and *that variable was provided*. This means that by
     * including/not including a specific variable in the request, a field can be added/removed from any input object
     * literals that reference the variable, which is powerful but can also be confusing.
     *
     * @see https://spec.graphql.org/draft/#sec-Input-Objects.Input-Coercion
     */
    final protected function hasValue(
        string $field_name,
        dict<string, Value\Value> $value_nodes,
        dict<string, mixed> $variable_values,
    ): bool {
        if (!C\contains_key($value_nodes, $field_name)) {
            return false;
        }
        $value_node = $value_nodes[$field_name];
        if ($value_node is Value\VariableRef) {
            return C\contains_key($variable_values, $value_node->getVarName());
        }
        return true;
    }
}
