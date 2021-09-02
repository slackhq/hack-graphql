
namespace Slack\GraphQL\Types;

use namespace HH\Lib\Vec;
use namespace Slack\GraphQL;

abstract class CompositeType extends NamedType {
    use TNonNullableType;
    use TNamedOutputType;

    const type TResolved = dict<string, mixed>;

    abstract const keyset<string> FIELD_NAMES;

    abstract public function getFieldDefinition(string $field_name): ?GraphQL\IFieldDefinition;

    <<__Override>>
    final public function getFields(bool $includeDeprecated = false): vec<GraphQL\Introspection\__Field> {
        return Vec\map($this::FIELD_NAMES, $field_name ==> $this->getFieldDefinition($field_name) as nonnull);
    }
}
