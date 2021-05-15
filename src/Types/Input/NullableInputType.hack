namespace Slack\GraphQL\Types;

use namespace Graphpinator\Parser\Value;
use namespace Slack\GraphQL;

final class NullableInputType<TInner as nonnull> extends InputType<?TInner> {
    use GraphQL\Introspection\IntrospectNullableType;

    public function __construct(private InputType<TInner> $inner_type) {}

    public function getInnerType(): GraphQL\Introspection\__Type {
        return $this->inner_type;
    }

    <<__Override>>
    public function coerceValue(mixed $value): ?TInner {
        return $value is null ? null : $this->inner_type->coerceValue($value);
    }

    <<__Override>>
    final public function coerceNonVariableNode(Value\Value $node, dict<string, mixed> $variable_values): ?TInner {
        return $node is Value\NullLiteral ? null : $this->inner_type->coerceNode($node, $variable_values);
    }

    <<__Override>>
    public function assertValidVariableValue(mixed $value): ?TInner {
        return $value is null ? null : $this->inner_type->assertValidVariableValue($value);
    }
}
