namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;
use namespace Graphpinator\Parser\Value;

final class NonNullableInputType<+TInner as nonnull>
    extends InputType<TInner>
    implements GraphQL\Introspection\IntrospectableGeneric {

    public function __construct(private InputType<TInner> $inner_type) {}

    <<__Override>>
    public function getName(): ?string {
        return null;
    }

    <<__Override>>
    public function coerceValue(mixed $value): TInner {
        return $this->inner_type->coerceValue($value);
    }

    <<__Override>>
    final public function coerceNonVariableNode(Value\Value $node, dict<string, mixed> $variable_values): TInner {
        return $this->inner_type->coerceNode($node, $variable_values);
    }

    <<__Override>>
    public function assertValidVariableValue(mixed $value): TInner {
        return $this->inner_type->assertValidVariableValue($value);
    }

    public function getTypeKind(): GraphQL\Introspection\__TypeKind {
        return GraphQL\Introspection\__TypeKind::NON_NULL;
    }

    public function getInnerType(): InputType<TInner> {
        return $this->inner_type;
    }
}
