namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

interface CompositeType {
    require extends BaseType;

    public function getFieldDefinition(string $field_name): ?GraphQL\IFieldDefinition;
}
