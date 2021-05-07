namespace Graphpinator\Typesystem;

interface EntityVisitor extends \Graphpinator\Typesystem\NamedTypeVisitor {
    public function visitSchema<TQuery, TMutation, TSubscription>(
        \Graphpinator\Type\Schema<TQuery, TMutation, TSubscription> $schema,
    ): mixed;

    public function visitDirective(\Graphpinator\Directive\Directive $directive): mixed;
}
