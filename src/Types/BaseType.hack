namespace Slack\GraphQL\Types;

// TODO: Implement introspection: https://spec.graphql.org/draft/#sec-Introspection
// It may or may not be a good idea to reuse the existing codegen to generate the introspection types.
// If we did that, then this would be:
// <<GraphQL\Object('__Type', '')>>
abstract class BaseType {
    // <<GraphQL\Field('name', '')>>
    abstract public function getName(): ?string;

    // TODO: kind, description, etc.
    // https://spec.graphql.org/draft/#sec-Schema-Introspection
}
