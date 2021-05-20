namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

<<__ConsistentConstruct>>
abstract class NamedType extends BaseType implements INonNullableType {

    abstract const type THackType as nonnull;
    abstract const string NAME;

    final private function __construct() {}

    <<__Override>>
    final public function getName(): string {
        return static::NAME;
    }

    <<__Override>>
    final public function unwrapType(): this {
        return $this;
    }

    <<__MemoizeLSB>>
    final public static function nonNullable(): this {
        return new static();
    }
}
