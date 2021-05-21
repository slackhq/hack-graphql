namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

abstract class BaseType implements GraphQL\Introspection\__Type {
    public function __construct(protected GraphQL\BaseSchema $schema) {}
    abstract public function unwrapType(): NamedType;
}
