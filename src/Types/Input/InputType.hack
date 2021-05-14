namespace Slack\GraphQL\Types;

use namespace HH\Lib\C;
use namespace Slack\GraphQL;
use namespace Graphpinator\Parser\{TypeRef, Value};

/**
 * GraphQL type that may be used for field/directive arguments and for variable values.
 * Includes scalar types, enums and input objects (GraphQL's version of dict).
 *
 * @see https://spec.graphql.org/draft/#sec-Input-and-Output-Types
 */
abstract class InputType<+TCoerced> extends BaseType {

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
    final public function coerceNode(Value\Value $node, dict<string, mixed> $variable_values): TCoerced {
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
     * Convenient wrappers around coerceValue() and coerceNode() that throw a more helpful exception if the coercion
     * being performed is for a specific argument or input object field.
     */
    final public function coerceNamedValue(
        string $name,
        KeyedContainer<arraykey, mixed> $values,
    ): TCoerced {
        try {
            return $this->coerceValue(idx($values, $name));
        } catch (GraphQL\UserFacingError $e) {
            if (C\contains_key($values, $name)) {
                throw $e->prependMessage('Invalid value for "%s"', $name);
            } else {
                throw new GraphQL\UserFacingError('Missing value for "%s"', $name);
            }
        }
    }

    final public function coerceNamedNode(
        string $name,
        dict<string, Value\Value> $nodes,
        dict<string, mixed> $variable_values,
    ): TCoerced {
        if (C\contains_key($nodes, $name)) {
            try {
                return $this->coerceNode($nodes[$name], $variable_values);
            } catch (GraphQL\UserFacingError $e) {
                throw $e->prependMessage('Invalid value for "%s"', $name);
            }
        } else {
            try {
                return $this->coerceValue(null);
            } catch (GraphQL\UserFacingError $e) {
                throw new GraphQL\UserFacingError('Missing value for "%s"', $name);
            }
        }
    }

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

    /**
     * Convert a parser node (e.g. from a variable declaration) to an instance of the input type it represents.
     */
    public static function fromNode(
        classname<GraphQL\BaseSchema> $schema,
        TypeRef\TypeRef $node,
        bool $nullable = true,
    ): InputType<mixed> {
        if ($node is TypeRef\NotNullRef) {
            return self::fromNode($schema, $node->getInnerRef(), false);
        }
        if ($node is TypeRef\ListTypeRef) {
            $inner = self::fromNode($schema, $node->getInnerRef());
            return $nullable ? $inner->nullableListOf() : $inner->nonNullableListOf();
        }
        $name = $node as TypeRef\NamedTypeRef->getName();
        $class = idx($schema::INPUT_TYPES, $name);
        if ($class is null) {
            throw new GraphQL\UserFacingError('Undefined input type "%s"', $name);
        }
        return $nullable ? $class::nullable() : $class::nonNullable();
    }
}
