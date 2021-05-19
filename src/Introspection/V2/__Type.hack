namespace Slack\GraphQL\Introspection\V2;

use Slack\GraphQL;

// TODO: add the rest of the introspection interfaces. Implement them in the
// base classes. We should just need to incldue the introspection fields the
// same way we did last time.

<<GraphQL\InterfaceType('__Type', 'Type introspection')>>
abstract class __Type {
    <<GraphQL\Field('kind', 'Kind of the type')>>
    abstract public function getKind(): __TypeKind;

    <<GraphQL\Field('name', 'Name of the type')>>
    public function getName(): ?string {
        return null;
    }

    <<GraphQL\Field('description', 'Description of the type')>>
    public function getDescription(): ?string {
        return null;
    }

    <<GraphQL\Field('fields', 'Fields of the type, only applies to OBJECT and INTERFACE')>>
    public function getFields(/* TODO support defaults bool $include_deprecated = false */): ?vec<__Field> {
        return null;
    }

    <<GraphQL\Field('interfaces', 'Interfaces the object implements, only applies to OBJECT')>>
    public function getInterfaces(): ?vec<__Type> {
        return null;
    }

    <<GraphQL\Field('possibleTypes', 'Possible types that implement this interface, only applies to INTERFACE')>>
    public function getPossibleTypes(): ?vec<__Type> {
        return null;
    }

    <<GraphQL\Field('enumValues', 'Enum values, only applies to ENUM')>>
    public function getEnumValues(/* TODO bool $include_deprecated = false */): ?vec<__EnumValue> {
        return null;
    }

    <<GraphQL\Field('inputFields', 'Input fields, only applies to INPUT_OBJECT')>>
    public function getInputFields(/* TODO bool $include_deprecated = false */): ?vec<__InputValue> {
        return null;
    }

    <<GraphQL\Field('ofType', 'Underlying wrapped type, only applies to NON_NULL and LIST')>>
    public function getOfType(): ?__Type {
        return null;
    }
}
