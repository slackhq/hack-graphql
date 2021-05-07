namespace Graphpinator\Parser\Value;

final class VariableRef implements \Graphpinator\Parser\Value\Value {

    public function __construct(private string $varName) {}

    public function getRawValue(): ?bool {
        throw new \RuntimeException('Operation not supported.');
    }

    public function getVarName(): string {
        return $this->varName;
    }

    public function accept(ValueVisitor $valueVisitor): mixed {
        return $valueVisitor->visitVariableRef($this);
    }
}
