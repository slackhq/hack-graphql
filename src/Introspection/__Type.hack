namespace Slack\GraphQL\Introspection;

use namespace Slack\GraphQL;

// TODO: add the rest of the introspection interfaces. Implement them in the
// base classes. We should just need to incldue the introspection fields the
// same way we did last time.

<<GraphQL\ObjectType('__Type', 'Type introspection')>>
abstract class __Type {

    <<GraphQL\Field('kind', 'Kind of the type')>>
    abstract public function getKind(): __TypeKind;

    <<GraphQL\Field('name', 'Name of the type')>>
    abstract public function getName(): ?string;

    <<GraphQL\Field('description', 'Description of the type')>>
    abstract public function getDescription(): ?string;

    <<GraphQL\Field('fields', 'Fields of the type, only applies to OBJECT and INTERFACE')>>
    abstract public function getFields(bool $include_deprecated = false): ?vec<__Field>;

    <<GraphQL\Field('interfaces', 'Interfaces the object implements, only applies to OBJECT')>>
    abstract public function getInterfaces(): ?vec<__Type>;

    <<GraphQL\Field('possibleTypes', 'Possible types that implement this interface, only applies to INTERFACE')>>
    abstract public function getPossibleTypes(): ?vec<__Type>;

    <<GraphQL\Field('enumValues', 'Enum values, only applies to ENUM')>>
    abstract public function getEnumValues(bool $include_deprecated = false): ?vec<__EnumValue>;

    <<GraphQL\Field('inputFields', 'Input fields, only applies to INPUT_OBJECT')>>
    abstract public function getInputFields(): ?vec<__InputValue>;

    <<GraphQL\Field('ofType', 'Underlying wrapped type, only applies to NON_NULL and LIST')>>
    abstract public function getOfType(): ?__Type;
}
