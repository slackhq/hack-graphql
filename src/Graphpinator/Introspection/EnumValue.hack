namespace Graphpinator\Introspection;

final class EnumValue extends \Graphpinator\Type\Type<\Graphpinator\EnumItem\EnumItem> {
    const NAME = '__EnumValue';
    const DESCRIPTION = 'Built-in introspection type.';

    public function __construct() {
        parent::__construct();
    }

    public function validateNonNullValue(mixed $rawValue): bool {
        return $rawValue is \Graphpinator\EnumItem\EnumItem;
    }

    protected function getFieldDefinition(): \Graphpinator\Field\ResolvableFieldSet<\Graphpinator\EnumItem\EnumItem> {
        return new \Graphpinator\Field\ResolvableFieldSet(dict[
            'name' => new \Graphpinator\Field\ResolvableField(
                'name',
                \Graphpinator\Container\Container::String()->notNull(),
                static function(\Graphpinator\EnumItem\EnumItem $item): string {
                    return $item->getName();
                },
            ),
            'description' => new \Graphpinator\Field\ResolvableField(
                'description',
                \Graphpinator\Container\Container::String(),
                static function(\Graphpinator\EnumItem\EnumItem $item): ?string {
                    return $item->getDescription();
                },
            ),
            'isDeprecated' => new \Graphpinator\Field\ResolvableField(
                'isDeprecated',
                \Graphpinator\Container\Container::Boolean()->notNull(),
                static function(\Graphpinator\EnumItem\EnumItem $item): bool {
                    return $item->isDeprecated();
                },
            ),
            'deprecationReason' => new \Graphpinator\Field\ResolvableField(
                'deprecationReason',
                \Graphpinator\Container\Container::String(),
                static function(\Graphpinator\EnumItem\EnumItem $item): ?string {
                    return $item->getDeprecationReason();
                },
            ),
        ]);
    }
}
