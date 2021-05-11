namespace Slack\GraphQL\Types;
use namespace Slack\GraphQL;

final class NullableOutputType<TInner> extends OutputType<?TInner> {

    public function __construct(private OutputType<TInner> $innerType) {}

    <<__Override>>
    public function getName(): ?string {
        return null;
    }

    public function getInnerType(): OutputType<TInner> {
        return $this->innerType;
    }

    /**
     * Nullable fields act as an "error boundary". Any InvalidFieldResults are converted to a ValidFieldResult (with
     * null value) here. Note the stronger return type compared to the parent class.
     */
    <<__Override>>
    public async function resolveAsync(
        ?TInner $value,
        \Graphpinator\Parser\Field\IHasFieldSet $field,
        GraphQL\__Private\Variables $vars,
    ): Awaitable<GraphQL\ValidFieldResult> {
        if ($value is null) {
            return new GraphQL\ValidFieldResult(null);
        }
        $result = await $this->innerType->resolveAsync($value, $field, $vars);
        return $result is GraphQL\ValidFieldResult
            ? $result
            : new GraphQL\ValidFieldResult(null, $result->getErrors());
    }

    public function resolveError(GraphQL\UserFacingError $error): GraphQL\ValidFieldResult {
        return new GraphQL\ValidFieldResult(null, vec[$error]);
    }
}
