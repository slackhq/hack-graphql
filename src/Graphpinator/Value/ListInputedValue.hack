namespace Graphpinator\Value;

final class ListInputedValue
    extends \Graphpinator\Value\ListValue<InputedValue>
    implements \Graphpinator\Value\InputedValue {
    public function __construct(\Graphpinator\Type\ListType $type, vec<\Graphpinator\Value\InputedValue> $value) {
        $this->type = $type;
        $this->value = $value;
    }

    public function getRawValue(bool $forResolvers = false): vec<mixed> {
        $return = vec[];

        foreach ($this->value as $listItem) {
            $listItem as InputedValue;
            $return[] = $listItem->getRawValue();
        }

        return $return;
    }

    public function getType(): \Graphpinator\Type\ListType {
        return $this->type;
    }

    public function printValue(): string {
        $component = vec[];

        foreach ($this->value as $value) {
            $value as InputedValue;
            $component[] = $value->printValue();
        }

        return '['.\implode(',', $component).']';
    }

    public function applyVariables(\Graphpinator\Normalizer\VariableValueSet $variables): void {
        foreach ($this->value as $value) {
            $value as InputedValue;
            $value->applyVariables($variables);
        }
    }

    public function isSame(?InputedValue $compare): bool {
        if (!$compare is this) {
            return false;
        }

        $secondArray = $compare->value;

        if (\count($secondArray) !== \count($this->value)) {
            return false;
        }

        foreach ($this->value as $key => $value) {
            $value as InputedValue;

            if (!\array_key_exists($key, $secondArray) || !$value->isSame($secondArray[$key])) {
                return false;
            }
        }

        return true;
    }
}
