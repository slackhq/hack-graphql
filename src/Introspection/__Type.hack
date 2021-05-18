namespace Slack\GraphQL\Introspection;

use Slack\GraphQL;

// TODO: add the rest of the introspection interfaces. Implement them in the
// base classes. We should just need to incldue the introspection fields the
// same way we did last time.

<<GraphQL\ObjectType('__Type', 'Type introspection')>>
interface __Type {

    <<GraphQL\Field('kind', 'Kind of the type')>>
    public function getKind(): __TypeKind;

    <<GraphQL\Field('name', 'Name of the type')>>
    public function getName(): ?string;

    // TODO:

    <<GraphQL\Field('description', 'Description of the type')>>
    public function getDescription(): ?string;

    <<GraphQL\Field('fields', 'Fields of the type, only applies to OBJECT and INTERFACE')>>
    public function getFields(/* TODO support defaults bool $include_deprecated = false */): ?vec<__Field>;

    // <<GraphQL\Field('interfaces', 'Interfaces the object implements, only applies to OBJECT')>>
    // public function getInterfaces(): ?vec<__Type>;

    // <<GraphQL\Field('possibleTypes', 'Possible types that implement this interface, only applies to INTERFACE')>>
    // public function getPossibleTypes(): ?vec<__Type>;

    // <<GraphQL\Field('enumValues', 'Enum values, only applies to ENUM')>>
    // public function getEnumValues(/* TODO bool $include_deprecated = false */): ?vec<__EnumValue>;

    // <<GraphQL\Field('inputFields', 'Input fields, only applies to INPUT_OBJECT')>>
    // public function getInputFields(/* TODO bool $include_deprecated = false */): ?vec<__InputValue>;

    <<GraphQL\Field('ofType', 'Underlying wrapped type, only applies to NON_NULL and LIST')>>
    public function getOfType(): ?__Type;
}
