namespace Graphpinator\Parser\TypeRef;

final class ListTypeRef extends \Graphpinator\Parser\TypeRef\TypeRef {

    public function __construct(int $id, \Graphpinator\Common\Location $location, private TypeRef $innerRef) {
        parent::__construct($id, $location);
    }

    public function getInnerRef(): TypeRef {
        return $this->innerRef;
    }

    public function print(): string {
        return '['.$this->innerRef->print().']';
    }
}
