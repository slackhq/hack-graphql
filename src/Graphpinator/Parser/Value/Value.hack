namespace Graphpinator\Parser\Value;

interface Value {
    // TODO: union: \stdClass|array|string|int|float|bool|null
    public function getRawValue(): mixed;

    public function accept(ValueVisitor $valueVisitor): mixed;
}
