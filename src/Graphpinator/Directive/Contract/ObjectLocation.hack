namespace Graphpinator\Directive\Contract;

interface ObjectLocation extends TypeSystemDefinition {
    public function validateObjectUsage(mixed $type, \Graphpinator\Value\ArgumentValueSet $arguments): bool;

    public function resolveObject(
        \Graphpinator\Value\ArgumentValueSet $arguments,
        \Graphpinator\Value\TypeValue $typeValue,
    ): void;
}
