namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

// TODO: Implement introspection: https://spec.graphql.org/draft/#sec-Introspection
// It may or may not be a good idea to reuse the existing codegen to generate the introspection types.
// If we did that, then this would be:
// <<GraphQL\Object('__Type', '')>>
abstract class BaseType implements GraphQL\Introspection\IntrospectableType {
    // <<GraphQL\Field('name', '')>>
    abstract public function getName(): ?string;
    abstract public function getTypeKind(): GraphQL\Introspection\__TypeKind;

    public function getDescription(): ?string {
        return null;
    }

    // TODO: kind, description, etc.
    // https://spec.graphql.org/draft/#sec-Schema-Introspection
}
