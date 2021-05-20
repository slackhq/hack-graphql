namespace Slack\GraphQL\Types;

use namespace Graphpinator\Parser\Value;
use namespace Slack\GraphQL;

final class IntType extends ScalarType {

    const type THackType = int;
    const string NAME = 'Int';

    const int MIN_SAFE_VALUE = -2147483648;
    const int MAX_SAFE_VALUE = 2147483647;

    <<__Override>>
    public function coerceValue(mixed $value): int {
        // TODO: Should we allow coercion from string and/or float? e.g. something like:
        // ($value is num || $value is string && \is_numeric($value)) && $value == (int)$value,
        if (!$value is int) {
            throw new GraphQL\UserFacingError('Expected an integer, got %s', (string)$value);
        }
        return self::assertInRange($value);
    }

    <<__Override>>
    final public function coerceNonVariableNode(Value\Value $node, dict<string, mixed> $variable_values): int {
        if (!$node is Value\IntLiteral) {
            throw new GraphQL\UserFacingError('Expected an Int literal, got %s', \get_class($node));
        }
        return self::assertInRange($node->getRawValue());
    }

    <<__Override>>
    protected function serialize(int $value): int {
        return self::assertInRange($value);
    }

    private static function assertInRange(int $value): int {
        GraphQL\assert(
            $value >= self::MIN_SAFE_VALUE && $value <= self::MAX_SAFE_VALUE,
            'Integers must be in 32-bit range, got %d',
            $value,
        );
        return $value;
    }
}
