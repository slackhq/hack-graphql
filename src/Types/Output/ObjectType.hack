namespace Slack\GraphQL\Types;

use namespace HH\Lib\{C, Dict};
use namespace Slack\GraphQL;

abstract class ObjectType extends CompositeType {
    abstract const dict<string, classname<InterfaceType>> INTERFACES;

    abstract public function getFieldDefinition(
        string $field_name,
    ): ?GraphQL\IResolvableFieldDefinition<this::THackType>;

    <<__Override>>
    final public async function resolveAsync(
        this::THackType $value,
        vec<\Graphpinator\Parser\Field\IHasSelectionSet> $parent_nodes,
        GraphQL\ExecutionContext $context,
    ): Awaitable<GraphQL\FieldResult<dict<string, mixed>>> {
        $grouped_child_fields = GraphQL\FieldCollector::collectFields($this, $parent_nodes, $context);

        $results = await Dict\map_async(
            $grouped_child_fields,
            async $grouped_field_nodes ==> {
                // Validation guarantees all of the grouped field nodes have the same name (i.e. we don't have one alias
                // pointing to 2 different fields in any selection set), so it doesn't matter which one we call
                // getName() on.
                $field_name = C\firstx($grouped_field_nodes)->getName();
                if ($field_name === '__typename') {
                    // https://spec.graphql.org/draft/#sec-Type-Name-Introspection
                    return new GraphQL\ValidFieldResult(static::NAME);
                }
                $field_definition = $this->getFieldDefinition($field_name);
                if ($field_definition is null) {
                    throw new \Slack\GraphQL\UserFacingError('Unknown field: %s', $field_name);
                }
                return await $field_definition->resolveAsync($value, $grouped_field_nodes, $context);
            },
        );

        return $this->buildResult($results);
    }

    private function buildResult(
        dict<string, GraphQL\FieldResult<mixed>> $results,
        dict<string, mixed> $ret = dict[],
        vec<GraphQL\UserFacingError> $errors = vec[],
    ): GraphQL\FieldResult<dict<string, mixed>> {
        $deferred_results = dict[];
        $is_valid = C\is_empty($errors);

        foreach ($results as $key => $result) {
            if ($result is GraphQL\DeferredFieldResult<_>) {
                $deferred_results[$key] = $result;
            } elseif ($result is GraphQL\ValidFieldResult<_>) {
                $ret[$key] = $result->getValue();
            } else {
                $is_valid = false;
            }
            foreach ($result->getErrors() as $error) {
                $errors[] = $error->prependPath($key);
            }
        }

        if (!C\is_empty($deferred_results)) {
            return new GraphQL\DeferredFieldResult(async () ==> {
                $results = await Dict\map_async($deferred_results, $result ==> $result->resolveAsync());
                return $this->buildResult($results, $ret, $errors);
            });
        }

        return $is_valid ? new GraphQL\ValidFieldResult($ret, $errors) : new GraphQL\InvalidFieldResult($errors);
    }

    <<__Override>>
    final public function getKind(): GraphQL\Introspection\__TypeKind {
        return GraphQL\Introspection\__TypeKind::OBJECT;
    }

    <<__Override>>
    final public function getInterfaces(): dict<string, classname<InterfaceType>> {
        return static::INTERFACES;
    }
}
