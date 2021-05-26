namespace Slack\GraphQL\Types;

use namespace HH\Lib\{C, Dict};
use namespace Slack\GraphQL;

final class ListOutputType<TInner, TResolved>
    extends BaseType
    implements INonNullableOutputTypeFor<vec<TInner>, vec<mixed>> {

    use TNonNullableType;
    use TOutputType<vec<TInner>, vec<mixed>>;

    public function __construct(private IOutputTypeFor<TInner, TResolved> $inner_type) {}

    <<__Override>>
    public function unwrapType(): INamedOutputType {
        return $this->inner_type->unwrapType();
    }

    <<__Override>>
    public async function resolveAsync(
        vec<TInner> $value,
        vec<\Graphpinator\Parser\Field\IHasSelectionSet> $parent_nodes,
        GraphQL\ExecutionContext $context,
    ): Awaitable<GraphQL\FieldResult<vec<mixed>>> {
        $results = await Dict\map_async(
            $value,
            async $item ==> await $this->inner_type->resolveAsync($item, $parent_nodes, $context),
        );
        return $this->buildResult($results);
    }

    private function buildResult(
        dict<int, GraphQL\FieldResult<mixed>> $results,
        dict<int, mixed> $ret = dict[],
        vec<GraphQL\UserFacingError> $errors = vec[],
    ): GraphQL\FieldResult<vec<mixed>> {
        $deferred_results = dict[];
        $is_valid = C\is_empty($errors);

        foreach ($results as $idx => $result) {
            if ($result is GraphQL\DeferredFieldResult<_>) {
                $deferred_results[$idx] = $result;
            } elseif ($result is GraphQL\ValidFieldResult<_>) {
                $ret[$idx] = $result->getValue();
            } else {
                $is_valid = false;
            }
            foreach ($result->getErrors() as $error) {
                $errors[] = $error->prependPath($idx);
            }
        }

        if (!C\is_empty($deferred_results)) {
            return new GraphQL\DeferredFieldResult(async () ==> {
                $results = await Dict\map_async($deferred_results, $result ==> $result->resolveAsync());
                return $this->buildResult($results, $ret, $errors);
            });
        }

        return $is_valid
            ? new GraphQL\ValidFieldResult(Dict\sort_by_key($ret) |> vec($$), $errors)
            : new GraphQL\InvalidFieldResult($errors);
    }

    /**
     * Introspection
     */
    <<__Override>>
    public function getName(): null {
        return null;
    }

    <<__Override>>
    public function getKind(): GraphQL\Introspection\__TypeKind {
        return GraphQL\Introspection\__TypeKind::LIST;
    }

    <<__Override>>
    public function getOfType(): GraphQL\Introspection\__Type {
        return $this->inner_type;
    }

    <<__Override>>
    public function nullableForIntrospection(): INullableType {
        return new NullableOutputType($this);
    }
}
