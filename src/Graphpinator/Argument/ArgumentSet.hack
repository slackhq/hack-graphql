namespace Graphpinator\Argument;

final class ArgumentSet extends \Infinityloop\Utils\ObjectMap<string, Argument> {
    private dict<string, mixed> $defaults = dict[];

    public function getRawDefaults(): dict<string, mixed> {
        return $this->defaults;
    }

    public function offsetSet(string $offset, Argument $value): void {
        parent::offsetSet($offset, $value);

        $defaultValue = $value->getDefaultValue();

        if ($defaultValue is \Graphpinator\Value\ArgumentValue) {
            $this->defaults[$value->getName()] = $defaultValue->getValue()->getRawValue();
        }
    }

    protected function getKey(Argument $object): string {
        return $object->getName();
    }
}
