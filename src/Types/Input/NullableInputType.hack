namespace Slack\GraphQL\Types;

use namespace Graphpinator\Parser\Value;
use namespace Slack\GraphQL;

final class NullableInputType<TInner as nonnull> extends InputType<?TInner> {

    public function __construct(private InputType<TInner> $inner_type) {}

    public function getName(): ?string {
        return null;
    }

    public function getInnerType(): GraphQL\Introspection\__Type {
        return $this->inner_type as GraphQL\Introspection\__Type;
    }

    <<__Override>>
    final public function unwrapType(): NamedInputType {
        return $this->inner_type->unwrapType();
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

    <<__Override>>
    final public function introspect(): GraphQL\Introspection\__Type {
        $inner = $this->inner_type->introspect();
        while ($inner is GraphQL\Introspection\NonNullableType) {
            $inner = $inner->getOfType();
        }
        return $inner;
    }
}
