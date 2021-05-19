namespace Slack\GraphQL\Introspection;

use namespace HH\Lib\Vec;

abstract class WrapperType implements __Type {

    final public function __construct(private __Type $ofType) {}

    <<__Override>>
    final public function getName(): ?string {
        return null;
    }

    <<__Override>>
    final public function getDescription(): ?string {
        return null;
    }

    <<__Override>>
    final public function getFields(bool $include_deprecated = false): ?vec<__Field> {
        return null;
    }
/*
    <<__Override>>
    final public function getInterfaces(): ?vec<__Type> {
        return null;
    }

    <<__Override>>
    final public function getPossibleTypes(): ?vec<__Type> {
        return null;
    }

    <<__Override>>
    final public function getEnumValues(bool $include_deprecated = false): ?vec<__EnumValue> {
        return null;
    }

    <<__Override>>
    final public function getInputFields(): ?vec<__InputValue> {
        return null;
    }
*/
    <<__Override>>
    final public function getOfType(): __Type {
        return $this->ofType;
    }
}


final class ListType extends WrapperType {
    <<__Override>>
    public function getKind(): __TypeKind {
        return __TypeKind::LIST;
    }
}


final class NonNullableType extends WrapperType {
    <<__Override>>
    public function getKind(): __TypeKind {
        return __TypeKind::NON_NULL;
    }
}
