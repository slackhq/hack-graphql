namespace Slack\GraphQL\Types;

use namespace Graphpinator\Parser\Value;
use type Slack\GraphQL\UserFacingError;

final class BooleanInputType extends NamedInputType {

    const type TCoerced = bool;
    const string NAME = 'Boolean';

    <<__Override>>
    public function coerceValue(mixed $value): bool {
        if (!$value is bool) {
            throw new UserFacingError('Expected a boolean, got %s', \gettype($value));
        }
        return $value;
    }

    <<__Override>>
    final public function coerceNonVariableNode(Value\Value $node, dict<string, mixed> $variable_values): bool {
        $value = $node->getRawValue();
        if (!$node is Value\Literal || !$value is bool) {
            throw new UserFacingError('Expected a Boolean literal, got %s', \get_class($node));
        }
        return $value;
    }
}
