namespace Slack\GraphQL\Introspection;

use namespace HH\Lib\Vec;

final class NamedTypeDeclaration extends __Type {

    public function __construct(
        private shape(
            'kind' => __TypeKind,
            'name' => string,
            ?'description' => ?string,
            ?'fields' => ?vec<__Field>,
            ?'interfaces' => ?vec<NamedTypeReference>,
            ?'possibleTypes' => ?vec<NamedTypeReference>,
            ?'enumValues' => ?vec<__EnumValue>,
            ?'inputFields' => ?vec<__InputValue>,
        ) $info,
    ) {}

    <<__Override>>
    public function getKind(): __TypeKind {
        return $this->info['kind'];
    }

    <<__Override>>
    public function getName(): ?string {
        return $this->info['name'];
    }

    <<__Override>>
    public function getDescription(): ?string {
        return $this->info['description'] ?? null;
    }

    <<__Override>>
    public function getFields(bool $include_deprecated = false): ?vec<__Field> {
        $fields = $this->info['fields'] ?? null;
        if ($fields is null) {
            return null;
        }
        if (!$include_deprecated) {
            $fields = Vec\filter($fields, $f ==> !$f['isDeprecated']);
        }
        return $fields;
    }

    <<__Override>>
    public function getInterfaces(): ?vec<__Type> {
        return $this->info['interfaces'] ?? null;
    }

    <<__Override>>
    public function getPossibleTypes(): ?vec<__Type> {
        return $this->info['possibleTypes'] ?? null;
    }

    <<__Override>>
    public function getEnumValues(bool $include_deprecated = false): ?vec<__EnumValue> {
        $enum_values = $this->info['enumValues'] ?? null;
        if ($enum_values is null) {
            return null;
        }
        if (!$include_deprecated) {
            $enum_values = Vec\filter($enum_values, $ev ==> !$ev['isDeprecated']);
        }
        return $enum_values;
    }

    <<__Override>>
    public function getInputFields(): ?vec<__InputValue> {
        return $this->info['inputFields'] ?? null;
    }

    <<__Override>>
    public function getOfType(): ?__Type {
        return null;
    }
}
