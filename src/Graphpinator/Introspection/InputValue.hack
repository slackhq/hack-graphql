namespace Graphpinator\Introspection;

final class InputValue extends \Graphpinator\Type\Type<\Graphpinator\Argument\Argument> {
    const NAME = '__InputValue';
    const DESCRIPTION = 'Built-in introspection type.';

    public function __construct(private \Graphpinator\Container\Container $container) {
        parent::__construct();
    }

    public function validateNonNullValue(mixed $rawValue): bool {
        return $rawValue is \Graphpinator\Argument\Argument;
    }

    protected function getFieldDefinition(): \Graphpinator\Field\ResolvableFieldSet<\Graphpinator\Argument\Argument> {
        return new \Graphpinator\Field\ResolvableFieldSet(dict[
            'name' => new \Graphpinator\Field\ResolvableField(
                'name',
                \Graphpinator\Container\Container::String()->notNull(),
                static function(\Graphpinator\Argument\Argument $argument): string {
                    return $argument->getName();
                },
            ),
            'description' => new \Graphpinator\Field\ResolvableField(
                'description',
                \Graphpinator\Container\Container::String(),
                static function(\Graphpinator\Argument\Argument $argument): ?string {
                    return $argument->getDescription();
                },
            ),
            'type' => new \Graphpinator\Field\ResolvableField(
                'type',
                $this->container->getType('__Type')?->notNull() as nonnull,
                static function(\Graphpinator\Argument\Argument $argument): \Graphpinator\Type\Contract\Definition {
                    return $argument->getType();
                },
            ),
            'defaultValue' => new \Graphpinator\Field\ResolvableField(
                'defaultValue',
                \Graphpinator\Container\Container::String(),
                static function(\Graphpinator\Argument\Argument $argument): ?string {
                    return $argument->getDefaultValue() is \Graphpinator\Value\ArgumentValue
                        ? $argument->getDefaultValue()?->getValue()?->printValue()
                        : null;
                },
            ),
        ]);
    }
}
