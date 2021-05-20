namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

abstract class BaseType {
    abstract public function getName(): ?string;

    abstract public function unwrapType(): NamedType;

    public function getDescription(): ?string {
        // TODO
        return null;
    }

    /**
    * Default implementation to return fields of the type. Only applies to
    * OBJECT and INTERFACE, which will override this method.
    */
    public function getFields(): ?vec<GraphQL\Introspection\__Field> {
        return null;
    }

    /**
    * Default implementation to return the wrapped type. Only applies to
    * NON_NULL and LIST.
    */
    public function getOfType(): ?GraphQL\Introspection\__Type {
        return null;
    }
}
