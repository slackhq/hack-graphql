namespace Slack\GraphQL\Types;

use namespace HH\Lib\{Dict, Vec};
use namespace Slack\GraphQL;

abstract class ObjectType extends CompositeType {

    abstract public function getFieldDefinition(
        string $field_name
    ): ?GraphQL\IResolvableFieldDefinition<this::THackType>;

    <<__Override>>
    final public async function resolveAsync(
        this::THackType $value,
        \Graphpinator\Parser\Field\IHasSelectionSet $field,
        GraphQL\Variables $vars,
    ): Awaitable<GraphQL\FieldResult<dict<string, mixed>>> {
        $ret = dict[];
        $errors = vec[];
        $is_valid = true;

        $child_fields = Dict\from_values(
            $field->getSelectionSet() as nonnull->getItems(),
            $f ==> {
                $f as \Graphpinator\Parser\Field\Field; // TODO: fragments
                return $f->getAlias() ?? $f->getName();
            },
        );

        $results = await Dict\map_async(
            $child_fields,
            async $child_field ==> {
                $child_field as \Graphpinator\Parser\Field\Field; // TODO: fragments
                if ($child_field->getName() === '__typename') {
                    // https://spec.graphql.org/draft/#sec-Type-Name-Introspection
                    return new GraphQL\ValidFieldResult(static::NAME);
                }
                $field_definition = $this->getFieldDefinition($child_field->getName());
                if ($field_definition is null) {
                    throw new \Slack\GraphQL\UserFacingError('Unknown field: %s', $child_field->getName());
                }
                return await $field_definition->resolveAsync($value, $child_field, $vars);
            }
        );

        foreach ($results as $key => $result) {
            if ($result is GraphQL\ValidFieldResult<_>) {
                $ret[$key] = $result->getValue();
            } else {
                $is_valid = false;
            }
            foreach ($result->getErrors() as $error) {
                $errors[] = $error->prependPath($key);
            }
        }

        return $is_valid ? new GraphQL\ValidFieldResult($ret, $errors) : new GraphQL\InvalidFieldResult($errors);
    }

    <<__Override>>
    final public function getKind(): GraphQL\Introspection\__TypeKind {
        return GraphQL\Introspection\__TypeKind::OBJECT;
    }
}
