


namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

abstract class BaseType implements GraphQL\Introspection\__Type {
    abstract public function unwrapType(): NamedType;
}
