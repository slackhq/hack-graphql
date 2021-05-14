namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;
use namespace Graphpinator\Parser\Value;

final class NullableInputType<+TInner as nonnull> extends InputType<?TInner> {

    public function __construct(private InputType<TInner> $inner_type) {}

    <<__Override>>
    public function getName(): ?string {
        return null;
    }

    <<__Override>>
    public function coerceValue(mixed $value): ?TInner {
        return $value is null ? null : $this->inner_type->coerceValue($value);
    }

    <<__Override>>
    final public function coerceNonVariableNode(Value\Value $node, dict<string, mixed> $variable_values): ?TInner {
        return $node is Value\Literal && $node->getRawValue() is null
            ? null
            : $this->inner_type->coerceNode($node, $variable_values);
    }

    <<__Override>>
    public function assertValidVariableValue(mixed $value): ?TInner {
        return $value is null ? null : $this->inner_type->assertValidVariableValue($value);
    }

    public function getTypeKind(): GraphQL\Introspection\__TypeKind {
        return $this->inner_type->getTypeKind();
    }
}
