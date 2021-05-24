namespace Graphpinator\Parser\Value;

final class VariableRef extends \Graphpinator\Parser\Value\Value {

    public function __construct(\Graphpinator\Common\Location $location, private string $varName) {
        parent::__construct($location);
    }

    public function getRawValue(): ?bool {
        throw new \RuntimeException('Operation not supported.');
    }

    public function getVarName(): string {
        return $this->varName;
    }
}
