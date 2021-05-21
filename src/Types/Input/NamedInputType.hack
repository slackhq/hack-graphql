namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

/**
 * Named type is any non-wrapping type.
 *
 * These are singletons. Get an instance using ::nullableInput() or ::nonNullable(), then call ->nullableInputListOf()
 * or ->nonNullableInputListOf() to get a list, list of lists, etc. of this type.
 *
 * @see https://spec.graphql.org/draft/#sec-Wrapping-Types
 */
interface INamedInputType extends INonNullableInputTypeFor<this::THackType> {
    require extends NamedType;

    <<__Enforceable>>
    abstract const type THackType as nonnull;

    public static function nullableInput(GraphQL\BaseSchema $_): NullableInputType<this::THackType>;
}

<<__ConsistentConstruct>>
trait TNamedInputType implements INamedInputType {
    use TInputType<this::THackType>;

    <<__Override>>
    final public function assertValidVariableValue(mixed $value): this::THackType {
        return $value as this::THackType;
    }

    <<__Override, __MemoizeLSB>>
    final public static function nullableInput(GraphQL\BaseSchema $schema): NullableInputType<this::THackType> {
        return new NullableInputType(static::nonNullable($schema));
    }

    <<__Override>>
    public function nullableForIntrospection(): INullableType {
        return static::nullableInput($this->schema);
    }
}
