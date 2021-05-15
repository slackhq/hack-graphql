namespace Slack\GraphQL\Introspection;

use namespace Slack\GraphQL;

<<GraphQL\InterfaceType('__EnumValue', 'Enum value introspection')>>
interface __EnumValue {

    <<GraphQL\Field('name', 'Name of the enum value')>>
    public function getName(): string;

    <<GraphQL\Field('description', 'Description of the enum value')>>
    public function getDescription(): ?string;

    <<GraphQL\Field('isDeprecated', 'Boolean for whether or not the enum value is deprecated')>>
    public function isDeprecated(): bool;

    <<GraphQL\Field('deprecationReason', 'Reason the enum value was deprecated')>>
    public function getDeprecationReason(): ?string;
}
