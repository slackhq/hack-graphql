namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

abstract class CompositeType extends NamedType {
    use TNamedOutputType;

    const type TCoerced = dict<string, mixed>;

    abstract const keyset<string> FIELD_NAMES;

    abstract public function getFieldDefinition(string $field_name): ?GraphQL\IFieldDefinition;
}
