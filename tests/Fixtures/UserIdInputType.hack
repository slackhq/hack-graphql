
use namespace Graphpinator\Parser\Value;
use namespace Slack\GraphQL;

newtype user_id_t = int;

function user_id_to_int(user_id_t $user_id): int {
    return $user_id;
}

final class UserIdInputType extends GraphQL\Types\NamedType {
    use GraphQL\Types\TNamedInputType;
    use GraphQL\Types\TNonNullableType;

    const string NAME = 'UserID';
    const type THackType = user_id_t;

    <<__Override>>
    final public function assertValidVariableValue(mixed $value): user_id_t {
        return $value as user_id_t;
    }

    <<__Override>>
    public function coerceValue(mixed $value): user_id_t {
        if (!$value is int) {
            throw new GraphQL\UserFacingError('Expected a UserId, got %s', (string)$value);
        }
        return $value;
    }

    <<__Override>>
    final public function coerceNonVariableNode(Value\Value $node, dict<string, mixed> $variable_values): user_id_t {
        if (!$node is Value\IntLiteral) {
            throw new GraphQL\UserFacingError('Expected a UserId literal, got %s', \get_class($node));
        }
        return $node->getRawValue();
    }

    <<__Override>>
    final public function getKind(): GraphQL\Introspection\__TypeKind {
        return GraphQL\Introspection\__TypeKind::SCALAR;
    }
}
