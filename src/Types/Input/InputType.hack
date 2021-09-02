


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
interface IInputType {
    require extends BaseType;

    public function unwrapType(): INamedInputType;

    /**
     * Validate/coerce a raw value to this type (i.e. a value that is not a parser node because it doesn't come from
     * inside the GraphQL query, e.g. it comes from the list of variable values that was supplied alongside the query).
     */
    public function coerceValue(mixed $value): mixed;

    /**
     * Validate/coerce a parser node (a parsed literal value, variable reference, or list/input object that needs to be
     * coerced recursively) to this type.
     *
     * Variable values are assumed to have already been validated/coerced (this is important because coercion is not
     * always idempotent).
     */
    public function coerceNode(Value\Value $node, dict<string, mixed> $variable_values): mixed;

    /**
     * Use these to get a singleton list type instance wrapping this type.
     */
    public function nullableInputListOf(): IInputType;
    public function nonNullableInputListOf(): IInputType;
}

interface IInputTypeFor<THackType> extends IInputType {
    public function coerceValue(mixed $value): THackType;
    public function coerceNode(Value\Value $node, dict<string, mixed> $variable_values): THackType;

    /**
     * This might be redundant assuming:
     * 1. The GraphQL query was validated.
     * 2. Variable values were validated/coerced.
     */
    public function assertValidVariableValue(mixed $value): THackType;

    /**
     * Convenient wrappers around coerceValue() and coerceNode() that throw a more helpful exception if the coercion
     * being performed is for a specific argument or input object field.
     */
    public function coerceNamedValue(string $name, KeyedContainer<arraykey, mixed> $values): THackType;
    public function coerceNamedNode(
        string $name,
        dict<string, Value\Value> $nodes,
        dict<string, mixed> $variable_values,
    ): THackType;
    public function coerceOptionalNamedNode(
        string $name,
        dict<string, Value\Value> $nodes,
        dict<string, mixed> $variable_values,
        THackType $default_value,
    ): THackType;
    public function nonNullableInputListOf(): ListInputType<THackType>;
    public function nullableInputListOf(): NullableInputType<vec<THackType>>;
}

interface INonNullableInputTypeFor<THackType as nonnull> extends INonNullableType, IInputTypeFor<THackType> {}

trait TInputType<THackType> implements IInputTypeFor<THackType> {

    final public function coerceNode(Value\Value $node, dict<string, mixed> $variable_values): THackType {
        return $node is Value\VariableRef
            ? $this->assertValidVariableValue(idx($variable_values, $node->getVarName()))
            : $this->coerceNonVariableNode($node, $variable_values);
    }

    abstract protected function coerceNonVariableNode(
        Value\Value $node,
        dict<string, mixed> $variable_values,
    ): THackType;

    final public function coerceNamedValue(string $name, KeyedContainer<arraykey, mixed> $values): THackType {
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
    ): THackType {
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

    final public function coerceOptionalNamedNode(
        string $name,
        dict<string, Value\Value> $nodes,
        dict<string, mixed> $variable_values,
        THackType $default_value,
    ): THackType {
        return $this->hasValue($name, $nodes, $variable_values)
            ? $this->coerceNamedNode($name, $nodes, $variable_values)
            : $default_value;
    }

    /**
     * Follows the GraphQL spec rules for whether an argument's default value should be used, or whether an input object
     * field should be included in the coerced shape -- either a literal value was provided, or the value is a variable
     * reference and *that variable was provided*.
     *
     * Note that this means that by including/not including a specific variable in the request, a field can be
     * added/removed from any input object literals that reference the variable, which is powerful but can also be
     * confusing.
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

    <<__Memoize>>
    public function nonNullableInputListOf(): ListInputType<THackType> {
        return new ListInputType($this);
    }

    <<__Memoize>>
    public function nullableInputListOf(): NullableInputType<vec<THackType>> {
        return new NullableInputType($this->nonNullableInputListOf());
    }

    /**
     * Convert a parser node (e.g. from a variable declaration) to an instance of the input type it represents.
     */
    public static function fromNode(
        GraphQL\BaseSchema $schema,
        TypeRef\TypeRef $node,
        bool $nullable = true,
    ): IInputType {
        if ($node is TypeRef\NotNullRef) {
            return self::fromNode($schema, $node->getInnerRef(), false);
        }
        if ($node is TypeRef\ListTypeRef) {
            $inner = self::fromNode($schema, $node->getInnerRef());
            return $nullable ? $inner->nullableInputListOf() : $inner->nonNullableInputListOf();
        }
        $name = $node as TypeRef\NamedTypeRef->getName();
        $class = idx($schema::TYPES, $name);
        if ($class is null) {
            throw new GraphQL\UserFacingError('Undefined type "%s"', $name);
        }
        $non_nullable = $class::nonNullable();
        if (!$non_nullable is INamedInputType) {
            throw new GraphQL\UserFacingError('Type "%s" is not an input type', $name);
        }
        return $nullable ? $non_nullable::nullableInput() : $non_nullable;
    }
}
