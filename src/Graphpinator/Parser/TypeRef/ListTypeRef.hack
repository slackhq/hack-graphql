namespace Graphpinator\Parser\TypeRef;

final class ListTypeRef implements \Graphpinator\Parser\TypeRef\TypeRef {

    public function __construct(private TypeRef $innerRef) {}

    public function getInnerRef(): TypeRef {
        return $this->innerRef;
    }

    public function print(): string {
        return '['.$this->innerRef->print().']';
    }
}
