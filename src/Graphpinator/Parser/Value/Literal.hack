namespace Graphpinator\Parser\Value;

abstract class Literal implements \Graphpinator\Parser\Value\Value {
    abstract const type THackType;

    final public function __construct(private this::THackType $value) {}

    final public function getRawValue(): this::THackType {
        return $this->value;
    }

    final public function accept(ValueVisitor $valueVisitor): mixed {
        return $valueVisitor->visitLiteral($this);
    }
}
