namespace Slack\GraphQL\Types;

use namespace Graphpinator\Parser\Value;
use namespace Slack\GraphQL;

final class BooleanInputType extends NamedInputType {

    const type THackType = bool;
    const string NAME = 'Boolean';

    <<__Override>>
    public function coerceValue(mixed $value): bool {
        if (!$value is bool) {
            throw new GraphQL\UserFacingError('Expected a boolean, got %s', (string)$value);
        }
        return $value;
    }

    <<__Override>>
    final public function coerceNonVariableNode(
        Value\Value $node,
        dict<string, mixed> $variable_values,
    ): bool {
        if (!$node is Value\BooleanLiteral) {
            throw new GraphQL\UserFacingError('Expected an Boolean literal, got %s', \get_class($node));
        }
        return $node->getRawValue();
    }
}
