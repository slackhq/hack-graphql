namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

abstract class LeafType extends NamedType {
    use TNonNullableType;
    use TNamedInputType;
    use TNamedOutputType;

    /**
     * Convert a Hack value to what should be returned in the GraphQL response. Throw UserFacingError if that is not
     * possible (e.g. Int out of 32-bit range).
     */
    abstract protected function serialize(this::THackType $value): this::TResolved;

    <<__Override>>
    final public async function resolveAsync(
        this::THackType $value,
        \Graphpinator\Parser\Field\IHasFieldSet $field,
        GraphQL\Variables $vars,
    ): Awaitable<GraphQL\FieldResult<this::TResolved>> {
        try {
            return new GraphQL\ValidFieldResult($this->serialize($value));
        } catch (GraphQL\UserFacingError $e) {
            return new GraphQL\InvalidFieldResult(vec[$e]);
        }
    }

    /**
     * As this is both an input and an output type, we have to arbitrarily pick one of static::nullableInput() and
     * static::nullableOutput() to return for introspection purposes (it doesn't matter which one).
     */
    <<__Override>>
    final public function nullableForIntrospection(): INullableType {
        return static::nullableInput();
    }
}
