namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

interface IOutputType {
    require extends BaseType;

    public function unwrapType(): INamedOutputType;
}

interface IOutputTypeFor<TExpected, TResolved> extends IOutputType {
    public function nonNullableListOfO(): ListOutputType<TExpected, TResolved>;
    public function nullableListOfO(): NullableOutputType<vec<TExpected>, vec<mixed>>;
    public function resolveAsync(
        TExpected $value,
        \Graphpinator\Parser\Field\IHasFieldSet $field,
        GraphQL\Variables $vars,
    ): Awaitable<GraphQL\FieldResult<TResolved>>;
    public function resolveError(GraphQL\UserFacingError $error): GraphQL\FieldResult<TResolved>;
}

interface INonNullableOutputTypeFor<TExpected as nonnull, TResolved>
    extends INonNullableType, IOutputTypeFor<TExpected, TResolved> {}

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
trait TOutputType<TExpected, TResolved> implements IOutputTypeFor<TExpected, TResolved> {

    /**
     * Use these to get a singleton list type instance wrapping this type.
     */
    <<__Memoize>>
    public function nonNullableListOfO(): ListOutputType<TExpected, TResolved> {
        return new ListOutputType($this);
    }

    <<__Memoize>>
    public function nullableListOfO(): NullableOutputType<vec<TExpected>, vec<mixed>> {
        return new NullableOutputType($this->nonNullableListOfO());
    }

    /**
     * Convert a value returned by the field resolver into what should be put in the GraphQL response, possibly
     * recursively.
     */
    abstract public function resolveAsync(
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
