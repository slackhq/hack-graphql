


namespace Graphpinator\Parser\Value;

final class ObjectVal extends \Graphpinator\Parser\Value\Value {

    public function __construct(\Graphpinator\Common\Location $location, private dict<string, Value> $value) {
        parent::__construct($location);
    }

    public function getValue(): dict<string, Value> {
        return $this->value;
    }
}
