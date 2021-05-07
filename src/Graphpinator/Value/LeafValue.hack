namespace Graphpinator\Value;

abstract class LeafValue implements \Graphpinator\Value\InputedValue, \Graphpinator\Value\OutputValue {

    protected \Graphpinator\Type\Contract\LeafDefinition $type;
    protected mixed $rawValue;

    public function __construct(\Graphpinator\Type\Contract\LeafDefinition $type, mixed $rawValue, bool $inputed) {
        if (!$type->validateNonNullValue($rawValue)) {
            throw new \Graphpinator\Exception\Value\InvalidValue($type->getName(), $rawValue, $inputed);
        }

        $this->type = $type;
        $this->rawValue = $rawValue;
    }

    public function getType(): \Graphpinator\Type\Contract\LeafDefinition {
        return $this->type;
    }

    public function jsonSerialize(): mixed {
        return $this->rawValue;
    }

    public function applyVariables(\Graphpinator\Normalizer\VariableValueSet $variables): void {
        // nothing here
    }

    public function isSame(?Value $compare): bool {
        return $compare is this && $this->rawValue === $compare->getRawValue();
    }
}
