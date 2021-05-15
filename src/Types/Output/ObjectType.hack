namespace Slack\GraphQL\Types;

use namespace HH\Lib\{Dict, Vec};
use namespace Slack\GraphQL;

abstract class ObjectType extends NamedOutputType implements GraphQL\Introspection\__Type {
    const type TCoerced = dict<string, mixed>;

    abstract const keyset<string> FIELD_NAMES;
    abstract public function getFieldDefinition(string $field_name): GraphQL\IFieldDefinition<this::THackType>;

    <<__Override>>
    final public async function resolveAsync(
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
            async $child_field ==>
                await $this->getFieldDefinition($child_field->getName())->resolveAsync($value, $child_field, $vars),
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

    <<__Override>>
    final public function getFields(): vec<GraphQL\Introspection\__Field> {
        return Vec\map($this::FIELD_NAMES, $field_name ==> $this->getFieldDefinition($field_name));
    }
}
