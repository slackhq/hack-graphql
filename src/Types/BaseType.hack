namespace Slack\GraphQL\Types;

abstract class BaseType {
    // Hack type associated with this GraphQL type (e.g. the class from which
    // a GraphQL object type was generated).
    abstract const type THackType;
}
