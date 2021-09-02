
namespace Slack\GraphQL\Introspection;

use Slack\GraphQL;

// TODO: add the rest of the introspection interfaces. Implement them in the
// base classes. We should just need to incldue the introspection fields the
// same way we did last time.

<<GraphQL\ObjectType('__Type', 'Type introspection')>>
interface __Type {

    <<GraphQL\Field('kind', 'Kind of the type')>>
    public function getIntrospectionKind(): __TypeKind;

    <<GraphQL\Field('name', 'Name of the type')>>
    public function getIntrospectionName(): ?string;

    // TODO: description
    <<GraphQL\Field('description', 'Description of the type')>>
    public function getIntrospectionDescription(): ?string;

    <<GraphQL\Field('fields', 'Fields of the type, only applies to OBJECT and INTERFACE')>>
    public function getIntrospectionFields(bool $includeDeprecated = false): ?vec<__Field>;

    <<GraphQL\Field('interfaces', 'Interfaces the object implements, only applies to OBJECT')>>
    public function getIntrospectionInterfaces(): ?vec<__Type>;

    <<GraphQL\Field('possibleTypes', 'Possible types that implement this interface, only applies to INTERFACE')>>
    public function getIntrospectionPossibleTypes(): ?vec<__Type>;

    <<GraphQL\Field('enumValues', 'Enum values, only applies to ENUM')>>
    public function getIntrospectionEnumValues(bool $includeDeprecated = false): ?vec<__EnumValue>;

    <<GraphQL\Field('inputFields', 'Input fields, only applies to INPUT_OBJECT')>>
    public function getIntrospectionInputFields(): ?vec<__InputValue>;

    <<GraphQL\Field('ofType', 'Underlying wrapped type, only applies to NON_NULL and LIST')>>
    public function getIntrospectionOfType(): ?__Type;
}
