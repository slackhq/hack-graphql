namespace Slack\GraphQL\Types;
use namespace Slack\GraphQL;

/**
 * GraphQL type that may be used for fields.
 * Includes scalar types, enums, object types, interfaces, and union types.
 *
 * TExpected is the type of the value we're expecting to receive from Hack. This may or may not be the same as
 * TResolved -- the type of the value that will be returned in the GraphQL response. For example, for object types, we
 * expect to receive an instance of a specific class from Hack, but we return a dict<string, mixed> to the GraphQL
 * client.
 *
 * @see https://spec.graphql.org/draft/#sec-Input-and-Output-Types
 */
abstract class OutputType<TExpected, TResolved> extends BaseType {

    /**
     * Use these to get a singleton list type instance wrapping this type.
     */
    <<__Memoize>>
    public function nonNullableListOf(): ListOutputType<TExpected, TResolved> {
        return new ListOutputType($this);
    }

    <<__Memoize>>
    public function nullableListOf(): NullableOutputType<vec<TExpected>, vec<mixed>> {
        return new NullableOutputType($this->nonNullableListOf());
    }

    /**
     * Convert a value returned by the field resolver into what should be put in the GraphQL response, possibly
     * recursively.
     */
    abstract public function resolveAsync(
        classname<GraphQL\Introspection\IntrospectableSchema> $schema,
        TExpected $value,
        \Graphpinator\Parser\Field\IHasFieldSet $field,
        GraphQL\Variables $vars,
    ): Awaitable<GraphQL\FieldResult<TResolved>>;

    /**
     * Convert an exception thrown by the field resolver into what should be put in the GraphQL response.
     */
    public function resolveError(GraphQL\UserFacingError $error): GraphQL\FieldResult<TResolved> {
        return new GraphQL\InvalidFieldResult(vec[$error]);
    }
}
