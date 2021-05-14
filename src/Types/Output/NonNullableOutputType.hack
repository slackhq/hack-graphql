namespace Slack\GraphQL\Types;
use namespace Slack\GraphQL;

final class NonNullableOutputType<TInner, TResolved>
    extends OutputType<TInner, TResolved>
    implements GraphQL\Introspection\IntrospectableGeneric {

    public function __construct(private OutputType<TInner, TResolved> $inner_type) {}

    <<__Override>>
    public function getName(): ?string {
        return null;
    }

    public function getInnerType(): OutputType<TInner, TResolved> {
        return $this->inner_type;
    }

    /**
     * Nullable fields act as an "error boundary". Any InvalidFieldResults are converted to a ValidFieldResult (with
     * null value) here. Note the stronger return type compared to the parent class.
     */
    <<__Override>>
    public async function resolveAsync(
        classname<GraphQL\Introspection\IntrospectableSchema> $schema,
        TInner $value,
        \Graphpinator\Parser\Field\IHasFieldSet $field,
        GraphQL\Variables $vars,
    ): Awaitable<GraphQL\FieldResult<TResolved>> {
        $result = await $this->inner_type->resolveAsync($schema, $value, $field, $vars);
        return $result is GraphQL\ValidFieldResult<_> ? $result : new GraphQL\InvalidFieldResult($result->getErrors());
    }

    public function resolveError(GraphQL\UserFacingError $error): GraphQL\InvalidFieldResult {
        return new GraphQL\InvalidFieldResult(vec[$error]);
    }

    public function getTypeKind(): GraphQL\Introspection\__TypeKind {
        return GraphQL\Introspection\__TypeKind::NON_NULL;
    }
}
