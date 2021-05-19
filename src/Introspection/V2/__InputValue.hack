namespace Slack\GraphQL\Introspection\V2;

use namespace Slack\GraphQL;

<<GraphQL\InterfaceType('__InputValue', 'Input value introspection'), __ConsistentConstruct>>
interface __InputValue {

    <<GraphQL\Field('name', 'Name of the field')>>
    public function getName(): string;

    <<GraphQL\Field('description', 'Description of the field')>>
    public function getDescription(): ?string;

    <<GraphQL\Field('type', 'Type of the field')>>
    public function getType(): __Type;

    <<GraphQL\Field('defaultValue', 'Default value the field')>>
    public function getDefaultValue(): ?string;
}
