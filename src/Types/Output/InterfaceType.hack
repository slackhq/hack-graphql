namespace Slack\GraphQL\Types;

use namespace HH\Lib\{Dict, Vec};
use namespace Slack\GraphQL;

abstract class InterfaceType extends CompositeType implements GraphQL\Introspection\__Type {

    <<__Override>>
    abstract public function resolveAsync(
        this::THackType $value,
        \Graphpinator\Parser\Field\IHasFieldSet $field,
        GraphQL\Variables $vars,
    ): Awaitable<GraphQL\FieldResult<dict<string, mixed>>>;

    <<__Override>>
    final public function getKind(): GraphQL\Introspection\__TypeKind {
        return GraphQL\Introspection\__TypeKind::INTERFACE;
    }

    <<__Override>>
    final public function getFields(): vec<GraphQL\Introspection\__Field> {
        return Vec\map($this::FIELD_NAMES, $field_name ==> $this->getFieldDefinition($field_name) as nonnull);
    }
}
