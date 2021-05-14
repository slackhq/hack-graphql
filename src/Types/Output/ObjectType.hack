namespace Slack\GraphQL\Types;

use namespace HH\Lib\Dict;
use namespace Slack\GraphQL;

abstract class ObjectType extends NamedOutputType implements GraphQL\Introspection\IntrospectableObject {
    const type TCoerced = dict<string, mixed>;

    abstract public function getFieldDefinition(string $field_name): GraphQL\IFieldDefinition<this::THackType>;

    public function getTypeKind(): GraphQL\Introspection\__TypeKind {
        return GraphQL\Introspection\__TypeKind::OBJECT;
    }

    <<__Override>>
    final public async function resolveAsync(
        classname<GraphQL\Introspection\IntrospectableSchema> $schema,
        this::THackType $value,
        \Graphpinator\Parser\Field\IHasFieldSet $field,
        GraphQL\Variables $vars,
    ): Awaitable<GraphQL\FieldResult<dict<string, mixed>>> {
        $ret = dict[];
        $errors = vec[];
        $is_valid = true;

        $child_fields = Dict\from_values(
            $field->getFields() as nonnull->getFields(),
            $f ==> $f->getAlias() ?? $f->getName(),
        );

        $results = await Dict\map_async(
            $child_fields,
            async $child_field ==> await $this->getFieldDefinition($child_field->getName())
                ->resolveAsync($schema, $value, $child_field, $vars),
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

    public function getFields(bool $include_deprecated = false): ?vec<GraphQL\Introspection\IntrospectableField> {
        // TODO
        return null;
    }

    public function getInterfaces(
        bool $include_deprecated = false,
    ): ?vec<GraphQL\Introspection\IntrospectableInterface> {
        // TODO
        return null;
    }
}
