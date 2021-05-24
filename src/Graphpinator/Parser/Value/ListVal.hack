namespace Graphpinator\Parser\Value;

final class ListVal extends \Graphpinator\Parser\Value\Value {

    public function __construct(int $id, \Graphpinator\Common\Location $location, private vec<Value> $value) {
        parent::__construct($id, $location);
    }

    public function getValue(): vec<Value> {
        return $this->value;
    }
}
