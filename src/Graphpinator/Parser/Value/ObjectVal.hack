namespace Graphpinator\Parser\Value;

final class ObjectVal implements Value {

    public function __construct(private dict<string, Value> $value) {}

    public function getValue(): dict<string, Value> {
        return $this->value;
    }

    public function accept(ValueVisitor $valueVisitor): mixed {
        return $valueVisitor->visitObjectVal($this);
    }
}
