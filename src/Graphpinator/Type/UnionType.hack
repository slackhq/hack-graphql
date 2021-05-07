namespace Graphpinator\Type;

abstract class UnionType extends \Graphpinator\Type\Contract\AbstractDefinition {
    use \Graphpinator\Type\Contract\TMetaFields;

    protected \Graphpinator\Type\TypeSet $types;

    public function __construct(\Graphpinator\Type\TypeSet $types) {
        $this->types = $types;
    }

    final public function getTypes(): \Graphpinator\Type\TypeSet {
        return $this->types;
    }

    final public function isInstanceOf(\Graphpinator\Type\Contract\Definition $type): bool {
        if ($type is NotNullType) {
            return $this->isInstanceOf($type->getInnerType());
        }

        return $type is this;
    }

    final public function isImplementedBy(\Graphpinator\Type\Contract\Definition $type): bool {
        foreach ($this->types as $temp) {
            if ($temp->isInstanceOf($type)) {
                return true;
            }
        }

        return false;
    }

    final public function accept(\Graphpinator\Typesystem\NamedTypeVisitor $visitor): mixed {
        return $visitor->visitUnion($this);
    }
}
