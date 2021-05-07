namespace Graphpinator\Parser\Value;

final class ListVal implements \Graphpinator\Parser\Value\Value {

    public function __construct(private vec<Value> $value) {}

    public function getValue(): vec<Value> {
        return $this->value;
    }

    public function getRawValue(): vec<mixed> {
        $return = vec[];

        foreach ($this->value as $value) {
            \assert($value is Value);
            $return[] = $value->getRawValue();
        }

        return $return;
    }

    public function accept(ValueVisitor $valueVisitor): mixed {
        return $valueVisitor->visitListVal($this);
    }
}
