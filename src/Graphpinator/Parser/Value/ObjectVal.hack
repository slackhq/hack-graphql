namespace Graphpinator\Parser\Value;

final class ObjectVal implements \Graphpinator\Parser\Value\Value {

    public function __construct(private dict<string, \Graphpinator\Parser\Value\Value> $value) {}

    public function getValue(): dict<string, \Graphpinator\Parser\Value\Value> {
        return $this->value;
    }

    public function getRawValue(): dict<string, mixed> {
        $return = dict[];

        foreach ($this->value as $key => $value) {
            \assert($value is Value);

            $return[$key] = $value->getRawValue();
        }

        return $return;
    }

    public function accept(ValueVisitor $valueVisitor): mixed {
        return $valueVisitor->visitObjectVal($this);
    }
}
