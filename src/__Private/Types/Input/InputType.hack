namespace Slack\GraphQL\__Private\Types;

use namespace Graphpinator\Parser\Value;

/**
 * GraphQL type that may be used for field/directive arguments and for variable values.
 * Includes scalar types, enums and input objects (GraphQL's version of dict).
 *
 * @see https://spec.graphql.org/draft/#sec-Input-and-Output-Types
 */
abstract class InputType<TCoerced> extends BaseType {

    /**
     * Validate/coerce a raw value to this type (i.e. a value that is not a parser node because it doesn't come from
     * inside the GraphQL query, e.g. it comes from the list of variable values that was supplied alongside the query).
     */
    abstract public function coerceValue(mixed $value): TCoerced;

    /**
     * Validate/coerce a parser node (a parsed literal value, variable reference, or list/input object that needs to be
     * coerced recursively) to this type.
     *
     * Variable values are assumed to have already been validated/coerced (this is important because coercion is not
     * always idempotent).
     */
    final public function coerceNode(
        Value\Value $node,
        dict<string, mixed> $variable_values,
    ): TCoerced {
        return $node is Value\VariableRef
            ? $this->assertValidVariableValue($variable_values[$node->getVarName()])
            : $this->coerceNonVariableNode($node, $variable_values);
    }

    abstract protected function coerceNonVariableNode(
        Value\Value $node,
        dict<string, mixed> $variable_values,
    ): TCoerced;

    /**
     * This might be redundant assuming:
     * 1. The GraphQL query was validated.
     * 2. Variable values were validated/coerced.
     */
    abstract protected function assertValidVariableValue(mixed $value): TCoerced;

    /**
     * Use these to get a singleton list type instance wrapping this type.
     */
    <<__Memoize>>
    public function nonNullableListOf(): ListInputType<TCoerced> {
        return new ListInputType($this);
    }

    <<__Memoize>>
    public function nullableListOf(): NullableInputType<vec<TCoerced>> {
        return new NullableInputType($this->nonNullableListOf());
    }
}
