namespace Graphpinator\Parser\Value;

final class EnumLiteral implements \Graphpinator\Parser\Value\Value {

    public function __construct(private string $value) {}

    public function getRawValue(): string {
        return $this->value;
    }

    public function accept(ValueVisitor $valueVisitor): mixed {
        return $valueVisitor->visitEnumLiteral($this);
    }
}
