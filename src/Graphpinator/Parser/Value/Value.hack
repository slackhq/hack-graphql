namespace Graphpinator\Parser\Value;

interface Value {
    public function accept(ValueVisitor $valueVisitor): mixed;
}
