


namespace Slack\GraphQL\Introspection;

use namespace Slack\GraphQL;

<<GraphQL\ObjectType('__Field', 'Field introspection')>>
interface __Field {

    <<GraphQL\Field('name', 'Name of the field')>>
    public function getName(): string;

    <<GraphQL\Field('description', 'Description of the field')>>
    public function getDescription(): ?string;

    <<GraphQL\Field('args', 'Args of the field')>>
    public function getArgs(): vec<__InputValue>;

    <<GraphQL\Field('type', 'Type of the field')>>
    public function getType(): __Type;

    <<GraphQL\Field('isDeprecated', 'Boolean for whether or not the field is deprecated')>>
    public function isDeprecated(): bool;

    <<GraphQL\Field('deprecationReason', 'Reason the field was deprecated')>>
    public function getDeprecationReason(): ?string;

}
