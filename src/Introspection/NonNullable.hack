namespace Slack\GraphQL\Introspection;

use namespace Slack\GraphQL;

final class NonNullable implements __Type {
    public function __construct(private __Type $inner_type) {}

    public function getKind(): __TypeKind {
        return __TypeKind::NON_NULL;
    }

    public function getType(): __Type {
        return $this->inner_type;
    }

    public function getName(): ?string {
        return null;
    }

    public function getDescription(): ?string {
        return null;
    }

    public function getFields(): ?vec<__Field> {
        return null;
    }

    public function getOfType(): __Type {
        return $this->inner_type;
    }
}
