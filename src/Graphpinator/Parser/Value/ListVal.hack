namespace Graphpinator\Parser\Value;

final class ListVal implements Value {

    public function __construct(private vec<Value> $value) {}

    public function getValue(): vec<Value> {
        return $this->value;
    }

    public function accept(ValueVisitor $valueVisitor): mixed {
        return $valueVisitor->visitListVal($this);
    }
}
