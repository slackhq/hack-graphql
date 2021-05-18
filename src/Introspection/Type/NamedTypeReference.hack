namespace Slack\GraphQL\Introspection;

use namespace HH\Lib\Vec;

final class NamedTypeReference extends __Type {

    public function __construct(
        private __Schema $schema,
        private string $name,
    ) {}

    <<__Memoize>>
    private function getDeclaration(): NamedTypeDeclaration {
        return $this->schema->getIntrospectionType($this->name);
    }

    <<__Override>>
    public function getKind(): __TypeKind {
        return $this->getDeclaration()->getKind();
    }

    <<__Override>>
    public function getName(): ?string {
        return $this->getDeclaration()->getName();
    }

    <<__Override>>
    public function getDescription(): ?string {
        return $this->getDeclaration()->getDescription();
    }

    <<__Override>>
    public function getFields(bool $include_deprecated = false): ?vec<__Field> {
        return $this->getDeclaration()->getFields($include_deprecated);
    }

    <<__Override>>
    public function getInterfaces(): ?vec<__Type> {
        return $this->getDeclaration()->getInterfaces();
    }

    <<__Override>>
    public function getPossibleTypes(): ?vec<__Type> {
        return $this->getDeclaration()->getPossibleTypes();
    }

    <<__Override>>
    public function getEnumValues(bool $include_deprecated = false): ?vec<__EnumValue> {
        return $this->getDeclaration()->getEnumValues();
    }

    <<__Override>>
    public function getInputFields(): ?vec<__InputValue> {
        return $this->getDeclaration()->getInputFields();
    }

    <<__Override>>
    public function getOfType(): ?__Type {
        return null;
    }
}
