


namespace Slack\GraphQL\Types;

use namespace Graphpinator\Parser\Value;
use namespace Slack\GraphQL;

final class FloatType extends ScalarType {

    const type THackType = float;
    const string NAME = 'Float';

    const int MIN_SAFE_VALUE = -2147483648;
    const int MAX_SAFE_VALUE = 2147483647;

    <<__Override>>
    public function coerceValue(mixed $value): float {
        if (!$value is float) {
            throw new GraphQL\UserFacingError('Expected a float, got %s', (string)$value);
        }
        return $value;
    }

    <<__Override>>
    final public function coerceNonVariableNode(Value\Value $node, dict<string, mixed> $variable_values): float {
        if (!$node is Value\FloatLiteral) {
            throw new GraphQL\UserFacingError('Expected a Float literal, got %s', \get_class($node));
        }
        return $node->getRawValue();
    }

    <<__Override>>
    protected function serialize(float $value): float {
        return $value;
    }
}
