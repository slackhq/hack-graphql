namespace Slack\GraphQL\Types;
use namespace Slack\GraphQL;

final class NullableOutputType<TInner, TResolved> extends OutputType<?TInner, ?TResolved> {

    public function __construct(private OutputType<TInner, TResolved> $inner_type) {}

    public function getName(): ?string {
        return null;
    }

    public function getInnerType(): GraphQL\Introspection\__Type {
        return $this->inner_type as GraphQL\Introspection\__Type;
    }

    <<__Override>>
    final public function unwrapType(): NamedOutputType {
        return $this->inner_type->unwrapType();
    }

    /**
     * Nullable fields act as an "error boundary". Any InvalidFieldResults are converted to a ValidFieldResult (with
     * null value) here. Note the stronger return type compared to the parent class.
     */
    <<__Override>>
    public async function resolveAsync(
        ?TInner $value,
        \Graphpinator\Parser\Field\IHasFieldSet $field,
        GraphQL\Variables $vars,
    ): Awaitable<GraphQL\ValidFieldResult<?TResolved>> {
        if ($value is null) {
            return new GraphQL\ValidFieldResult(null);
        }
        $result = await $this->inner_type->resolveAsync($value, $field, $vars);
        return $result is GraphQL\ValidFieldResult<_>
            ? $result
            : new GraphQL\ValidFieldResult(null, $result->getErrors());
    }

    public function resolveError(GraphQL\UserFacingError $error): GraphQL\ValidFieldResult<null> {
        return new GraphQL\ValidFieldResult(null, vec[$error]);
    }

    <<__Override>>
    final public function introspect(): GraphQL\Introspection\__Type {
        $inner = $this->inner_type->introspect();
        while ($inner is GraphQL\Introspection\NonNullableType) {
            $inner = $inner->getOfType();
        }
        return $inner;
    }
}
