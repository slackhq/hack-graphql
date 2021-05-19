namespace Slack\GraphQL\Introspection\V2;

use namespace HH\Lib\Vec;

abstract class InputObjectType extends NamedType {
    abstract const dict<string, classname<__InputValue>> INPUT_FIELDS;

    <<__Override>>
    public function getKind(): __TypeKind {
        return __TypeKind::INPUT_OBJECT;
    }

    <<__Override>>
    public function getInputFields(/* include_deprecated = false */): vec<__InputValue> {
        return Vec\map(static::INPUT_FIELDS, $field ==> new $field());
    }
}
