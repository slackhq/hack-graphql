namespace Graphpinator\Type;

final class Schema<TQuery, TMutation, TSubscription> implements \Graphpinator\Typesystem\Entity {
    use \Graphpinator\Utils\TOptionalDescription;

    public function __construct(
        private \Graphpinator\Container\Container $container,
        private \Graphpinator\Type\Type<TQuery> $query,
        private ?\Graphpinator\Type\Type<TMutation> $mutation = null,
        private ?\Graphpinator\Type\Type<TSubscription> $subscription = null,
    ) {
        $this->query->addMetaField(new \Graphpinator\Field\ResolvableField(
            '__schema',
            $this->container->getType('__Schema')?->notNull() as nonnull,
            function($_): this {
                return $this;
            },
        ));
        $this->query->addMetaField(
            \Graphpinator\Field\ResolvableField::create(
                '__type',
                $this->container->getType('__Type') as nonnull,
                function(shape('name' => string, ...) $args): ?\Graphpinator\Type\Contract\Definition {
                    return $this->container->getType($args['name'] as string);
                },
            )->setArguments(new \Graphpinator\Argument\ArgumentSet(dict[
                'name' =>
                    new \Graphpinator\Argument\Argument('name', \Graphpinator\Container\Container::String()->notNull()),
            ])),
        );
    }

    public function getContainer(): \Graphpinator\Container\Container {
        return $this->container;
    }

    public function getQuery(): \Graphpinator\Type\Type<TQuery> {
        return $this->query;
    }

    public function getMutation(): ?\Graphpinator\Type\Type<TMutation> {
        return $this->mutation;
    }

    public function getSubscription(): ?\Graphpinator\Type\Type<TSubscription> {
        return $this->subscription;
    }

    public function accept(\Graphpinator\Typesystem\EntityVisitor $visitor): mixed {
        return $visitor->visitSchema($this);
    }
}
