


namespace Slack\GraphQL\Types;

use namespace HH\Lib\{C, Vec};
use namespace Slack\GraphQL;
use namespace Graphpinator\Parser\Value;

<<__ConsistentConstruct>>
abstract class InputObjectType extends NamedType {
    use TNonNullableType;
    use TNamedInputType;

    abstract const type THackType as shape(...);
    abstract const keyset<string> FIELD_NAMES;

    <<__Override>>
    final public function coerceValue(mixed $value): this::THackType {
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
    abstract protected function getInputValue(string $field_name): ?GraphQL\Introspection\__InputValue;

    <<__Override>>
    final protected function coerceNonVariableNode(
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

    <<__Override>>
    final public function assertValidVariableValue(mixed $value): this::THackType {
        return $this->assertValidFieldValues($value as KeyedContainer<_, _>);
    }

    abstract protected function assertValidFieldValues(KeyedContainer<arraykey, mixed> $values): this::THackType;

    <<__Override>>
    final public function getKind(): GraphQL\Introspection\__TypeKind {
        return GraphQL\Introspection\__TypeKind::INPUT_OBJECT;
    }

    <<__Override>>
    final public function getInputFields(): vec<GraphQL\Introspection\__InputValue> {
        return Vec\map(static::FIELD_NAMES, $field_name ==> $this->getInputValue($field_name) as nonnull);
    }
}
