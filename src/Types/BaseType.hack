namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

abstract class BaseType {
    abstract public function getName(): ?string;

    /**
     * Return an introspection-compatible version of this type (nullable types are unwrapped, regular types are wrapped
     * in Introspection\NonNullableType, some input types delegate to their respective output type, to avoid code
     * duplication).
     */
    abstract public function introspect(): GraphQL\Introspection\__Type;
}
