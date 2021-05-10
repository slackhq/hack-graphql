namespace Slack\GraphQL\__Private\Types;

use namespace HH\Lib\Vec;
use namespace Graphpinator\Parser\Value;
use type Slack\GraphQL\UserFacingError;

final class ListInputType<TInner> extends InputType<vec<TInner>> {

    public function __construct(private InputType<TInner> $innerType) {}

    <<__Override>>
    public function getName(): ?string {
        return null;
    }

    <<__Override>>
    public function coerceValue(mixed $value): vec<TInner> {
        if (!$value is Container<_>) {
            // See https://spec.graphql.org/draft/#sec-Type-System.List.Input-Coercion
            return vec[$this->innerType->coerceValue($value)];
        }
        return Vec\map($value, $item ==> $this->innerType->coerceValue($item));
    }

    <<__Override>>
    final public function coerceNonVariableNode(
        Value\Value $node,
        dict<string, mixed> $variable_values,
    ): vec<TInner> {
        if (!$node is Value\ListVal) {
            return vec[$this->innerType->coerceNode($node, $variable_values)];
        }
        return Vec\map($node->getValue(), $item_node ==> $this->innerType->coerceNode($item_node, $variable_values));
    }

    <<__Override>>
    public function assertValidVariableValue(mixed $value): vec<TInner> {
        return Vec\map($value as vec<_>, $item ==> $this->innerType->coerceValue($item));
    }
}
