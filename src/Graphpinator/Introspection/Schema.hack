namespace Graphpinator\Introspection;

final class Schema<TQuery, TMutation, TSubscription>
    extends \Graphpinator\Type\Type<\Graphpinator\Type\Schema<TQuery, TMutation, TSubscription>> {
    const NAME = '__Schema';
    const DESCRIPTION = 'Built-in introspection type.';

    public function __construct(private \Graphpinator\Container\Container $container) {
        parent::__construct();
    }

    public function validateNonNullValue(mixed $rawValue): bool {
        // TODO: fix
        // return $rawValue is \Graphpinator\Type\Schema;
        return true;
    }

    protected function getFieldDefinition(
    ): \Graphpinator\Field\ResolvableFieldSet<\Graphpinator\Type\Schema<TQuery, TMutation, TSubscription>> {
        return new \Graphpinator\Field\ResolvableFieldSet(dict[
            'description' => new \Graphpinator\Field\ResolvableField(
                'description',
                \Graphpinator\Container\Container::String(),
                static function(\Graphpinator\Type\Schema<TQuery, TMutation, TSubscription> $schema): ?string {
                    return $schema->getDescription();
                },
            ),
            'types' => new \Graphpinator\Field\ResolvableField(
                'types',
                $this->container->getType('__Type')?->notNullList() as nonnull,
                static function(
                    \Graphpinator\Type\Schema<TQuery, TMutation, TSubscription> $schema,
                ): dict<string, mixed> {
                    return $schema->getContainer()->getTypes(true);
                },
            ),
            'queryType' => new \Graphpinator\Field\ResolvableField(
                'queryType',
                $this->container->getType('__Type')?->notNull() as nonnull,
                static function(
                    \Graphpinator\Type\Schema<TQuery, TMutation, TSubscription> $schema,
                ): \Graphpinator\Type\Contract\Definition {
                    return $schema->getQuery();
                },
            ),
            'mutationType' => new \Graphpinator\Field\ResolvableField(
                'mutationType',
                $this->container->getType('__Type') as nonnull,
                static function(
                    \Graphpinator\Type\Schema<TQuery, TMutation, TSubscription> $schema,
                ): ?\Graphpinator\Type\Contract\Definition {
                    return $schema->getMutation();
                },
            ),
            'subscriptionType' => new \Graphpinator\Field\ResolvableField(
                'subscriptionType',
                $this->container->getType('__Type') as nonnull,
                static function(
                    \Graphpinator\Type\Schema<TQuery, TMutation, TSubscription> $schema,
                ): ?\Graphpinator\Type\Contract\Definition {
                    return $schema->getMutation();
                },
            ),
            'directives' => new \Graphpinator\Field\ResolvableField(
                'directives',
                $this->container->getType('__Directive')?->notNullList() as nonnull,
                static function(
                    \Graphpinator\Type\Schema<TQuery, TMutation, TSubscription> $schema,
                ): dict<string, mixed> {
                    return $schema->getContainer()->getDirectives(true);
                },
            ),
        ]);
    }
}
