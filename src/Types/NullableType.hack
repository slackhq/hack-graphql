namespace Slack\GraphQL\Types;

use namespace HH\Lib\Vec;
use namespace Slack\GraphQL\Introspection;

interface INullableType {
    require extends BaseType;
    public function getInnerType(): INonNullableType;
}

trait TNullableType implements INullableType {

    /**
     * GraphQL introspection doesn't use Nullable wrappers, so present this as an unwrapped type (delegate everything
     * to the inner type).
     */
    <<__Override>>
    final public function getIntrospectionKind(): Introspection\__TypeKind {
        return $this->getInnerType()->getKind();
    }

    <<__Override>>
    final public function getIntrospectionName(): ?string {
        return $this->getInnerType()->getName();
    }

    <<__Override>>
    final public function getIntrospectionDescription(): ?string {
        return $this->getInnerType()->getDescription();
    }

    <<__Override>>
    final public function getIntrospectionFields(bool $includeDeprecated = false): ?vec<Introspection\__Field> {
        return $this->getInnerType()->getFields();
    }

    <<__Override>>
    final public function getIntrospectionInterfaces(): ?vec<Introspection\__Type> {
        $interfaces = $this->getInnerType()->getInterfaces();
        return $interfaces is nonnull ? Vec\map($interfaces, $interface ==> $interface::nullableOutput()) : null;
    }

    <<__Override>>
    final public function getIntrospectionPossibleTypes(): ?vec<Introspection\__Type> {
        $types = $this->getInnerType()->getPossibleTypes();
        return $types is nonnull ? Vec\map($types, $type ==> $type::nullableOutput()) : null;
    }

    <<__Override>>
    final public function getIntrospectionEnumValues(
        bool $includeDeprecated = false,
    ): ?vec<Introspection\__EnumValue> {
        return $this->getInnerType()->getEnumValues();
    }

    <<__Override>>
    final public function getIntrospectionInputFields(
        bool $includeDeprecated = false,
    ): ?vec<Introspection\__InputValue> {
        return $this->getInnerType()->getInputFields();
    }

    <<__Override>>
    final public function getIntrospectionOfType(): ?Introspection\__Type {
        return $this->getInnerType()->getOfType();
    }
}
