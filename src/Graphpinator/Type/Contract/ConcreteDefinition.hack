namespace Graphpinator\Type\Contract;

abstract class ConcreteDefinition extends \Graphpinator\Type\Contract\NamedDefinition {
    public function isInstanceOf(\Graphpinator\Type\Contract\Definition $type): bool {
        if ($type is \Graphpinator\Type\NotNullType) {
            return $this->isInstanceOf($type->getInnerType());
        }

        return $type is ConcreteDefinition;
    }
}
