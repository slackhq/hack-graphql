namespace Graphpinator\Parser\Value;

final class VariableRef extends \Graphpinator\Parser\Value\Value {

    public function __construct(int $id, \Graphpinator\Common\Location $location, private string $varName) {
        parent::__construct($id, $location);
    }

    public function getRawValue(): ?bool {
        throw new \RuntimeException('Operation not supported.');
    }

    public function getVarName(): string {
        return $this->varName;
    }
}
