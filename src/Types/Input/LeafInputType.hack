namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

abstract class LeafInputType extends NamedInputType {
    abstract const classname<LeafOutputType> OUTPUT_TYPE_CLASS;

    <<__Override>>
    final public function introspect(): GraphQL\Introspection\__Type {
        $class = static::OUTPUT_TYPE_CLASS;
        return $class::nonNullable()->introspect();
    }
}
