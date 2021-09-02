
namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

/**
 * GraphQL type that may be used for fields.
 * Includes scalar types, enums, object types, interfaces, and union types.
 *
 * THackType is the type of the value we're expecting to receive from Hack. This may or may not be the same as
 * TResolved -- the type of the value that will be returned in the GraphQL response. For example, for object types, we
 * expect to receive an instance of a specific class from Hack, but we return a dict<string, mixed> to the GraphQL
 * client.
 *
 * @see https://spec.graphql.org/draft/#sec-Input-and-Output-Types
 */
interface IOutputType {
    require extends BaseType;

    public function unwrapType(): INamedOutputType;
}

interface IOutputTypeFor<THackType, TResolved> extends IOutputType {

    /**
     * Use these to get a singleton list type instance wrapping this type.
     */
    public function nonNullableOutputListOf(): ListOutputType<THackType, TResolved>;
    public function nullableOutputListOf(): NullableOutputType<vec<THackType>, vec<mixed>>;

    /**
     * Convert a value returned by the field resolver into what should be put in the GraphQL response, possibly
     * recursively.
     *
     * Note that due to how FieldCollector works, there might be multiple parent nodes representing the same GraphQL
     * response field (e.g. if the same field was included via 2 different fragments).
     */
    public function resolveAsync(
        THackType $value,
        vec<\Graphpinator\Parser\Field\IHasSelectionSet> $parent_nodes,
        GraphQL\ExecutionContext $context,
    ): Awaitable<GraphQL\FieldResult<TResolved>>;

    /**
     * Convert an exception thrown by the field resolver into what should be put in the GraphQL response.
     */
    public function resolveError(GraphQL\UserFacingError $error): GraphQL\FieldResult<TResolved>;
}

interface INonNullableOutputTypeFor<THackType as nonnull, TResolved>
    extends INonNullableType, IOutputTypeFor<THackType, TResolved> {}

trait TOutputType<THackType, TResolved> implements IOutputTypeFor<THackType, TResolved> {

    <<__Memoize>>
    final public function nonNullableOutputListOf(): ListOutputType<THackType, TResolved> {
        return new ListOutputType($this);
    }

    <<__Memoize>>
    final public function nullableOutputListOf(): NullableOutputType<vec<THackType>, vec<mixed>> {
        return new NullableOutputType($this->nonNullableOutputListOf());
    }

    public function resolveError(GraphQL\UserFacingError $error): GraphQL\FieldResult<TResolved> {
        return new GraphQL\InvalidFieldResult(vec[$error]);
    }
}
