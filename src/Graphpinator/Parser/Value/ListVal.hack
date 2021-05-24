namespace Graphpinator\Parser\Value;

final class ListVal extends \Graphpinator\Parser\Value\Value {

    public function __construct(\Graphpinator\Common\Location $location, private vec<Value> $value) {
        parent::__construct($location);
    }

    public function getValue(): vec<Value> {
        return $this->value;
    }
}
