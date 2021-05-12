namespace Slack\GraphQL;

class Field implements \HH\MethodAttribute {
    public function __construct(private string $name, private string $description) {}

    public function getName(): string {
        return $this->name;
    }
}

/**
 * Must be used in combination with GraphQL\Field, on a method with a non-nullable return type in Hack. If present, the
 * field will be surfaced to GraphQL clients as *non-nullable* (without this, even methods with a non-nullable Hack
 * return type are surfaced as *nullable* GraphQL fields).
 *
 * This has the effect that if the Hack method throws an exception, instead of returning `null` as the field value, the
 * exception is propagated to be handled by the parent field. If the parent field is nullable, then it resolves to null,
 * otherwise the exception is further propagated to its parent field, possibly all the way up to the query root (the
 * 'data' field will be null in the GraphQL response).
 *
 * Non-nullable fields are useful because they allow clients to avoid null checks on every GraphQL field; but also
 * potentially dangerous because they can cause a large part of the response, or even the whole response, to be thrown
 * away because of a single field that failed to resolve.
 *
 * It's generally safe to use this on Hack methods that are guaranteed to never throw exceptions, but unfortunately Hack
 * provides no way to enforce such contract, so it might still be risky if the method's code changes in the future.
 *
 * @see https://spec.graphql.org/draft/#sec-Handling-Field-Errors
 */
final class KillsParentOnException implements \HH\MethodAttribute {
    public function __construct() {}
}
