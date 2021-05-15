namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

abstract class BaseType implements GraphQL\Introspection\__Type {
    <<__Override>>
    abstract public function getName(): ?string;

    <<__Override>>
    public function getDescription(): ?string {
        // TODO
        return null;
    }

    /**
    * Default implementation to return fields of the type. Only applies to
    * OBJECT and INTERFACE, which will override this method.
    */
    <<__Override>>
    public function getFields(): ?vec<GraphQL\Introspection\__Field> {
        return null;
    }

    /**
    * Default implementation to return the wrapped type. Only applies to
    * NON_NULL and LIST.
    */
    <<__Override>>
    public function getOfType(): ?GraphQL\Introspection\__Type {
        return null;
    }
}
