namespace Slack\GraphQL\Types;

use namespace Graphpinator\Parser\Value;
use type Slack\GraphQL\UserFacingError;
use namespace Slack\GraphQL;

final class StringType extends ScalarType {

    const type THackType = string;
    const string NAME = 'String';

    <<__Override>>
    public function coerceValue(mixed $value): string {
        if (!$value is string) {
            throw new UserFacingError('Expected a string, got %s', \gettype($value));
        }
        return $value;
    }

    <<__Override>>
    final public function coerceNonVariableNode(Value\Value $node, dict<string, mixed> $variable_values): string {
        if (!$node is Value\StringLiteral) {
            throw new UserFacingError('Expected a String literal, got %s', \get_class($node));
        }
        return $node->getRawValue();
    }

    <<__Override>>
    protected function serialize(string $value): string {
        return $value;
    }
}
