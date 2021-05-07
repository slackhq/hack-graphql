namespace Graphpinator\Value;

final class ArgumentValueSet extends \Infinityloop\Utils\ObjectMap<string, ArgumentValue> {

    public function getValuesForResolver(): dict<string, mixed> {
        $return = dict[];

        foreach ($this as $name => $argumentValue) {
            $return[$name] = $argumentValue->getValue()->getRawValue(true);
        }

        return $return;
    }

    public function applyVariables(\Graphpinator\Normalizer\VariableValueSet $variables): void {
        foreach ($this as $value) {
            $value->applyVariables($variables);
        }
    }

    public function isSame(?ArgumentValueSet $compare): bool {
        if ($compare is null) return false;

        foreach ($compare as $lhs) {
            if ($this->offsetExists($lhs->getArgument()->getName())) {
                if ($lhs->getValue()->isSame($this->offsetGet($lhs->getArgument()->getName())->getValue())) {
                    continue;
                }

                return false;
            }

            if ($lhs->getValue()->isSame($lhs->getArgument()->getDefaultValue()?->getValue())) {
                continue;
            }

            return false;
        }

        foreach ($this as $lhs) {
            if ($compare->offsetExists($lhs->getArgument()->getName())) {
                continue;
            }

            if ($lhs->getValue()->isSame($lhs->getArgument()->getDefaultValue()?->getValue())) {
                continue;
            }

            return false;
        }

        return true;
    }

    protected function getKey(ArgumentValue $object): string {
        return $object->getArgument()->getName();
    }
}
