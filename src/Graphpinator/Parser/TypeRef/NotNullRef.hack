


namespace Graphpinator\Parser\TypeRef;

final class NotNullRef extends \Graphpinator\Parser\TypeRef\TypeRef {

    public function __construct(\Graphpinator\Common\Location $location, private TypeRef $innerRef) {
        parent::__construct($location);
    }

    public function getInnerRef(): TypeRef {
        return $this->innerRef;
    }

    public function print(): string {
        return $this->innerRef->print().'!';
    }
}
