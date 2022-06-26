
use namespace Graphpinator\Parser\Value;
use namespace Slack\GraphQL;

final class Channel {
    public function __construct(private string $input) {}
}

final class ChannelInputType extends GraphQL\Types\NamedType {
    use GraphQL\Types\TNamedInputType;
    use GraphQL\Types\TNonNullableType;

    const string NAME = 'ChannelID';
    const type THackType = Channel;

    <<__Override>>
    final public function assertValidVariableValue(mixed $value): Channel {
        return $value as Channel;
    }

    <<__Override>>
    public function coerceValue(mixed $value): Channel {
        if (!$value is string) {
            throw new GraphQL\UserFacingError('Expected a ChannelID, got %s', (string)$value);
        }
        return new Channel($value);
    }

    <<__Override>>
    final public function coerceNonVariableNode(Value\Value $node, dict<string, mixed> $variable_values): Channel {
        if (!$node is Value\StringLiteral) {
            throw new GraphQL\UserFacingError('Expected an ChannelID literal, got %s', \get_class($node));
        }
        return new Channel($node->getRawValue());
    }

    <<__Override>>
    final public function getKind(): GraphQL\Introspection\__TypeKind {
        return GraphQL\Introspection\__TypeKind::SCALAR;
    }
}
