namespace Graphpinator\Parser\Value;

final class Literal implements \Graphpinator\Parser\Value\Value {

    public function __construct(private mixed $value) {}

    public function getRawValue(): mixed {
        return $this->value;
    }

    public function accept(ValueVisitor $valueVisitor): mixed {
        return $valueVisitor->visitLiteral($this);
    }
}
