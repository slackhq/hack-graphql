namespace Graphpinator\Introspection;

final class Field extends \Graphpinator\Type\Type<\Graphpinator\Field\Field> {
    const NAME = '__Field';
    const DESCRIPTION = 'Built-in introspection type.';

    public function __construct(private \Graphpinator\Container\Container $container) {
        parent::__construct();
    }

    public function validateNonNullValue(mixed $rawValue): bool {
        return $rawValue is \Graphpinator\Field\Field;
    }

    protected function getFieldDefinition(): \Graphpinator\Field\ResolvableFieldSet<\Graphpinator\Field\Field> {
        return new \Graphpinator\Field\ResolvableFieldSet(dict[
            'name' => new \Graphpinator\Field\ResolvableField(
                'name',
                \Graphpinator\Container\Container::String()->notNull(),
                static function(\Graphpinator\Field\Field $field): string {
                    return $field->getName();
                },
            ),
            'description' => new \Graphpinator\Field\ResolvableField(
                'description',
                \Graphpinator\Container\Container::String(),
                static function(\Graphpinator\Field\Field $field): ?string {
                    return $field->getDescription();
                },
            ),
            'args' => new \Graphpinator\Field\ResolvableField(
                'args',
                $this->container->getType('__InputValue')?->notNullList() as nonnull,
                static function(\Graphpinator\Field\Field $field): \Graphpinator\Argument\ArgumentSet {
                    return $field->getArguments();
                },
            ),
            'type' => new \Graphpinator\Field\ResolvableField(
                'type',
                $this->container->getType('__Type')?->notNull() as nonnull,
                static function(\Graphpinator\Field\Field $field): \Graphpinator\Type\Contract\Definition {
                    return $field->getType();
                },
            ),
            'isDeprecated' => new \Graphpinator\Field\ResolvableField(
                'isDeprecated',
                \Graphpinator\Container\Container::Boolean()->notNull(),
                static function(\Graphpinator\Field\Field $field): bool {
                    return $field->isDeprecated();
                },
            ),
            'deprecationReason' => new \Graphpinator\Field\ResolvableField(
                'deprecationReason',
                \Graphpinator\Container\Container::String(),
                static function(\Graphpinator\Field\Field $field): ?string {
                    return $field->getDeprecationReason();
                },
            ),
        ]);
    }
}
