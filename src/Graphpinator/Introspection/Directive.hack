namespace Graphpinator\Introspection;

final class Directive extends \Graphpinator\Type\Type<shape('directive' => \Graphpinator\Directive\Directive, ...)> {
    const NAME = '__Directive';
    const DESCRIPTION = 'Built-in introspection type.';

    public function __construct(private \Graphpinator\Container\Container $container) {
        parent::__construct();
    }

    public function validateNonNullValue(mixed $rawValue): bool {
        return $rawValue is \Graphpinator\Directive\Directive;
    }

    protected function getFieldDefinition(
    ): \Graphpinator\Field\ResolvableFieldSet<shape('directive' => \Graphpinator\Directive\Directive, ...)> {
        return new \Graphpinator\Field\ResolvableFieldSet(dict[
            'name' => new \Graphpinator\Field\ResolvableField(
                'name',
                \Graphpinator\Container\Container::String()->notNull(),
                static function(shape('directive' => \Graphpinator\Directive\Directive, ...) $args): string {
                    return $args['directive']->getName();
                },
            ),
            'description' => new \Graphpinator\Field\ResolvableField(
                'description',
                \Graphpinator\Container\Container::String(),
                static function(shape('directive' => \Graphpinator\Directive\Directive, ...) $args): ?string {
                    return $args['directive']->getDescription();
                },
            ),
            'locations' => new \Graphpinator\Field\ResolvableField(
                'locations',
                $this->container->getType('__DirectiveLocation')?->notNullList() as nonnull,
                static function(shape('directive' => \Graphpinator\Directive\Directive, ...) $args): vec<string> {
                    return $args['directive']->getLocations();
                },
            ),
            'args' => new \Graphpinator\Field\ResolvableField(
                'args',
                $this->container->getType('__InputValue')?->notNullList() as nonnull,
                static function(
                    shape('directive' => \Graphpinator\Directive\Directive, ...) $args,
                ): \Graphpinator\Argument\ArgumentSet {
                    return $args['directive']->getArguments();
                },
            ),
            'isRepeatable' => new \Graphpinator\Field\ResolvableField(
                'isRepeatable',
                \Graphpinator\Container\Container::Boolean()->notNull(),
                static function(shape('directive' => \Graphpinator\Directive\Directive, ...) $args): bool {
                    return $args['directive']->isRepeatable();
                },
            ),
        ]);
    }
}
