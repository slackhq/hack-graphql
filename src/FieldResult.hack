
namespace Slack\GraphQL;

/**
 * These classes capture the possible results of resolving a GraphQL field during GraphQL execution.
 */
<<__Sealed(InvalidFieldResult::class, ValidFieldResult::class)>>
abstract class FieldResult<+T> {
    public function __construct(private vec<UserFacingError> $errors) {}

    final public function getErrors(): vec<UserFacingError> {
        return $this->errors;
    }
}

/**
 * A valid result encapsulates a value that can be included in the GraphQL response and optionally any errors.
 * All these combinations are possible:
 * - non-null value without error, if everything goes well
 * - null value without error, if this field's implementation returned null and the field is nullable
 * - non-null value with error, if this object/list field is OK but has 1 or more nullable children with errors
 * - null value with error, if this is a nullable field that failed to resolve
 */
final class ValidFieldResult<+T> extends FieldResult<T> {
    public function __construct(private T $value, vec<UserFacingError> $errors = vec[]) {
        parent::__construct($errors);
    }

    public function getValue(): T {
        return $this->value;
    }
}

/**
 * An invalid result cannot be included in the GraphQL response (generally a non-nullable field that failed to resolve).
 * The error needs to be propagated to the closest parent nullable field, at which point a ValidFieldResult will be
 * returned, with null value and the same error.
 */
final class InvalidFieldResult extends FieldResult<nothing> {
}
