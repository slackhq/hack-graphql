namespace Slack\GraphQL\Introspection;

use namespace HH\Lib\Vec;

interface IntrospectableSchema {
    public static function getTypes(): vec<IntrospectableType>;
    public static function getQueryType(): IntrospectableType;
    public static function getMutationType(): ?IntrospectableType;
    public static function getType(string $name): ?IntrospectableType;
}

interface IntrospectableType {
    public function getName(): ?string;
    public function getDescription(): ?string;
    public function getTypeKind(): __TypeKind;
}

interface IntrospectableTypeWithFields extends IntrospectableType {
    public function getFields(bool $include_deprecated = false): ?vec<IntrospectableField>;
}

interface IntrospectableObject extends IntrospectableTypeWithFields {
    public function getFields(bool $include_deprecated = false): ?vec<IntrospectableField>;
    public function getInterfaces(): ?vec<IntrospectableInterface>;
    public static function nonNullable(): IntrospectableType;
    public static function nullable(): IntrospectableType;
    public static function literal(): IntrospectableType;
}

interface IntrospectableInterface extends IntrospectableTypeWithFields {
    public function getFields(bool $include_deprecated = false): ?vec<IntrospectableField>;
    public function getPossibleTypes(): ?vec<IntrospectableType>;
}

interface IntrospectableEnum extends IntrospectableType {
    public function getEnumValues(bool $include_deprecated = false): ?vec<IntrospectableEnumValue>;
}

interface IntrospectableInput extends IntrospectableType {
    public function getInputFields(bool $include_deprecated = false): ?vec<IntrospectableInputValue>;
}

interface IntrospectableGeneric {
    public function getInnerType(): IntrospectableType;
}

interface IntrospectableNamedType {
    public function getName(): string;
    public function getDescription(): ?string;
}

interface IntrospectableField extends IntrospectableNamedType {
    public function getArgs(): vec<IntrospectableInputValue>;
    public function getType(): IntrospectableType;
    public function isDeprecated(): bool;
    public function getDeprecationReason(): ?string;
}

interface IntrospectableInputValue extends IntrospectableNamedType {
    public function getType(): IntrospectableType;
    public function defaultValue(): ?string;
}

interface IntrospectableEnumValue extends IntrospectableNamedType {
    public function isDeprecated(): bool;
    public function getDeprecationReason(): ?string;
}

final abstract class IntrospectionQueryFields {
    // filter out the schema argument if it is an introspection field?
    <<\Slack\GraphQL\QueryRootField('__schema', 'Introspect the schema')>>
    public static function getSchema(classname<IntrospectableSchema> $schema): ?__Schema {
        return new __Schema($schema);
    }

    <<\Slack\GraphQL\QueryRootField('__type', 'Introspect a specific type')>>
    public static function getType(classname<IntrospectableSchema> $schema, string $name): ?__Type {
        $type = $schema::getType($name);
        return $type is nonnull ? new __Type($type) : null;
    }
}

<<\Slack\GraphQL\EnumType('__TypeKind', '__TypeKind')>>
enum __TypeKind: string {
    SCALAR = 'SCALAR';
    OBJECT = 'OBJECT';
    INTERFACE = 'INTERFACE';
    UNION = 'UNION';
    ENUM = 'ENUM';
    INPUT_OBJECT = 'INPUT_OBJECT';
    LIST = 'LIST';
    NON_NULL = 'NON_NULL';
}

<<\Slack\GraphQL\ObjectType('__Schema', 'Schema introspection')>>
final class __Schema {
    public function __construct(private classname<IntrospectableSchema> $schema) {}

    <<\Slack\GraphQL\Field('types', 'Types contained within the schema')>>
    public function getTypes(): vec<__Type> {
        $schema = $this->schema;
        return Vec\map($schema::getTypes(), $type ==> new __Type($type));
    }

    <<\Slack\GraphQL\Field('queryType', 'Query root type')>>
    public function getQueryType(): __Type {
        $schema = $this->schema;
        return new __Type($schema::getQueryType());
    }

    <<\Slack\GraphQL\Field('mutationType', 'Mutation root type')>>
    public function getMutationType(): ?__Type {
        $schema = $this->schema;
        $mutation_type = $schema::getMutationType();
        return $mutation_type is nonnull ? new __Type($mutation_type) : null;
    }
}

<<\Slack\GraphQL\ObjectType('__Type', 'Type introspection')>>
final class __Type {
    public function __construct(private IntrospectableType $inner_type) {}

    <<\Slack\GraphQL\Field('kind', 'Kind of the type')>>
    public function getKind(): __TypeKind {
        $inner_type = $this->inner_type;
        return $inner_type->getTypeKind();
    }

    <<\Slack\GraphQL\Field('name', 'Name of the type')>>
    public function getName(): ?string {
        $inner_type = $this->inner_type;
        return $inner_type->getName();
    }

    <<\Slack\GraphQL\Field('description', 'Description of the type')>>
    public function getDescription(): ?string {
        $inner_type = $this->inner_type;
        return $inner_type->getDescription();
    }

    <<\Slack\GraphQL\Field('fields', 'Fields in the type, only applies to OBJECT and INTERFACE')>>
    public function getFields(bool $include_deprecated = false): ?vec<__Field> {
        if ($this->inner_type is IntrospectableObject || $this->inner_type is IntrospectableInterface) {
            $fields = $this->inner_type->getFields($include_deprecated);
            return $fields is nonnull ? Vec\map($fields, $field ==> new __Field($field)) : null;
        }

        return null;
    }

    <<\Slack\GraphQL\Field('interfaces', 'Interfaces the object implements, only applies to OBJECT')>>
    public function getInterfaces(): ?vec<__Type> {
        if ($this->inner_type is IntrospectableObject) {
            $interfaces = $this->inner_type->getInterfaces();
            return $interfaces is nonnull ? Vec\map($interfaces, $interface ==> new __Type($interface)) : null;
        }

        return null;
    }

    <<\Slack\GraphQL\Field('possibleTypes', 'Possible types that implement this interface, only applies to INTERFACE')>>
    public function getPossibleTypes(): ?vec<__Type> {
        if ($this->inner_type is IntrospectableInterface) {
            $types = $this->inner_type->getPossibleTypes();
            return $types is nonnull ? Vec\map($types, $type ==> new __Type($type)) : null;
        }

        return null;
    }

    <<\Slack\GraphQL\Field('enumValues', 'Enum values, only applies to ENUM')>>
    public function getEnumValues(bool $include_deprecated = false): ?vec<__EnumValue> {
        if ($this->inner_type is IntrospectableEnum) {
            $enum_values = $this->inner_type->getEnumValues($include_deprecated);
            return $enum_values is nonnull ? Vec\map($enum_values, $enum_value ==> new __EnumValue($enum_value)) : null;
        }

        return null;
    }

    <<\Slack\GraphQL\Field('inputFields', 'Input fields, only applies to INPUT_OBJECT')>>
    public function getInputFields(bool $include_deprecated = false): ?vec<__InputValue> {
        if ($this->inner_type is IntrospectableInput) {
            $input_fields = $this->inner_type->getInputFields($include_deprecated);
            return $input_fields is nonnull
                ? Vec\map($input_fields, $input_field ==> new __InputValue($input_field))
                : null;
        }

        return null;
    }

    <<\Slack\GraphQL\Field('ofType', 'Type parameter for generic, only applies to NON_NULL and LIST')>>
    public function getOfType(): ?__Type {
        if ($this->inner_type is IntrospectableGeneric) {
            $type = $this->inner_type->getInnerType();
            return $type is nonnull ? new __Type($type) : null;
        }

        return null;
    }
}

<<\Slack\GraphQL\ObjectType('__Field', 'Field introspection')>>
final class __Field {
    public function __construct(private IntrospectableField $inner_type) {}

    <<\Slack\GraphQL\Field('name', 'Name of the field')>>
    public function getName(): string {
        return $this->inner_type->getName();
    }

    <<\Slack\GraphQL\Field('description', 'Description of the field')>>
    public function getDescription(): ?string {
        return $this->inner_type->getDescription();
    }

    <<\Slack\GraphQL\Field('args', 'Args of the field')>>
    public function getArgs(): vec<__InputValue> {
        return Vec\map($this->inner_type->getArgs(), $arg ==> new __InputValue($arg));
    }

    <<\Slack\GraphQL\Field('type', 'Type of the field')>>
    public function getType(): __Type {
        return new __Type($this->inner_type->getType());
    }

    <<\Slack\GraphQL\Field('isDeprecated', 'Boolean for whether or not the field is deprecated')>>
    public function isDeprecated(): bool {
        return $this->inner_type->isDeprecated();
    }

    <<\Slack\GraphQL\Field('deprecationReason', 'Reason the field was deprecated')>>
    public function getDeprecationReason(): ?string {
        return $this->inner_type->getDeprecationReason();
    }

}

<<\Slack\GraphQL\ObjectType('__EnumValue', 'Enum value introspection')>>
final class __EnumValue {
    public function __construct(private IntrospectableEnumValue $inner_type) {}

    <<\Slack\GraphQL\Field('name', 'Name of the enum value')>>
    public function getName(): string {
        return $this->inner_type->getName();
    }

    <<\Slack\GraphQL\Field('description', 'Description of the enum value')>>
    public function getDescription(): ?string {
        return $this->inner_type->getDescription();
    }

    <<\Slack\GraphQL\Field('isDeprecated', 'Boolean for whether or not the enum value is deprecated')>>
    public function isDeprecated(): bool {
        return $this->inner_type->isDeprecated();
    }

    <<\Slack\GraphQL\Field('deprecationReason', 'Reason the enum value was deprecated')>>
    public function getDeprecationReason(): ?string {
        return $this->inner_type->getDeprecationReason();
    }
}

<<\Slack\GraphQL\ObjectType('__InputValue', 'Input value introspection')>>
final class __InputValue {
    public function __construct(private IntrospectableInputValue $inner_type) {}

    <<\Slack\GraphQL\Field('name', 'Name of the field')>>
    public function getName(): string {
        return $this->inner_type->getName();
    }

    <<\Slack\GraphQL\Field('description', 'Description of the field')>>
    public function getDescription(): ?string {
        return $this->inner_type->getDescription();
    }

    <<\Slack\GraphQL\Field('type', 'Type of the field')>>
    public function getType(): __Type {
        return new __Type($this->inner_type->getType());
    }

    // TODO: Not sure how this is possible for input objects? Maybe if they're a class?
    <<\Slack\GraphQL\Field('defaultValue', 'Default value the field')>>
    public function getDefaultValue(): ?string {
        return null;
    }
}
