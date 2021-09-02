
namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL\Introspection;

interface INonNullableType {
    require extends BaseType;
    public function getKind(): Introspection\__TypeKind;
    public function getName(): ?string;
    public function getDescription(): ?string;
    public function getFields(bool $includeDeprecated = false): ?vec<Introspection\__Field>;
    public function getInterfaces(): ?dict<string, classname<InterfaceType>>;
    public function getPossibleTypes(): ?vec<classname<ObjectType>>;
    public function getEnumValues(bool $includeDeprecated = false): ?vec<Introspection\__EnumValue>;
    public function getInputFields(): ?vec<Introspection\__InputValue>;
    public function getOfType(): ?Introspection\__Type;
    public function nullableForIntrospection(): INullableType;
}

trait TNonNullableType implements INonNullableType {

    /**
     * GraphQL introspection requires non-nullable types to be represented by the nullable version of the type wrapped
     * in a NON_NULL wrapper. So we return the data for the NON_NULL wrapper here (everything except Kind and OfType is
     * null), with OfType returning the nullable version of the type (which, when introspected, will be presented as an
     * unwrapped type -- see the TNullableType trait).
     */
    <<__Override>>
    final public function getIntrospectionKind(): Introspection\__TypeKind {
        return Introspection\__TypeKind::NON_NULL;
    }

    <<__Override>>
    final public function getIntrospectionName(): ?string {
        return null;
    }

    <<__Override>>
    final public function getIntrospectionDescription(): ?string {
        return null;
    }

    <<__Override>>
    final public function getIntrospectionFields(bool $includeDeprecated = false): ?vec<Introspection\__Field> {
        return null;
    }

    <<__Override>>
    final public function getIntrospectionInterfaces(): ?vec<Introspection\__Type> {
        return null;
    }

    <<__Override>>
    final public function getIntrospectionPossibleTypes(): ?vec<Introspection\__Type> {
        return null;
    }

    <<__Override>>
    final public function getIntrospectionEnumValues(bool $includeDeprecated = false): ?vec<Introspection\__EnumValue> {
        return null;
    }

    <<__Override>>
    final public function getIntrospectionInputFields(
        bool $includeDeprecated = false,
    ): ?vec<Introspection\__InputValue> {
        return null;
    }

    <<__Override>>
    final public function getIntrospectionOfType(): ?Introspection\__Type {
        return $this->nullableForIntrospection();
    }

    /**
     * These are the *actual* introspection values for this type (subclasses should override any relevant ones).
     *
     * These are not returned when this type is introspected directly (see explanation above), but they will be returned
     * if this type is introspected through a Nullable wrapper.
     */
    public function getDescription(): ?string {
        return null;
    }

    public function getFields(bool $includeDeprecated = false): ?vec<Introspection\__Field> {
        return null;
    }

    public function getInterfaces(): ?dict<string, classname<InterfaceType>> {
        return null;
    }

    public function getPossibleTypes(): ?vec<classname<ObjectType>> {
        return null;
    }

    public function getEnumValues(bool $includeDeprecated = false): ?vec<Introspection\__EnumValue> {
        return null;
    }

    public function getInputFields(): ?vec<Introspection\__InputValue> {
        return null;
    }

    public function getOfType(): ?Introspection\__Type {
        return null;
    }
}
