namespace Slack\GraphQL\Introspection\V2;

use namespace HH\Lib\Vec;

abstract class EnumType extends ScalarType {
    abstract const dict<string, classname<__EnumValue>> ENUM_VALUES;

    <<__Override>>
    public function getKind(): __TypeKind {
        return __TypeKind::ENUM;
    }

    public function getEnumValues(/* include_deprecated = false */): vec<__EnumValue> {
        return Vec\map(static::ENUM_VALUES, $enum ==> new $enum());
    }
}
