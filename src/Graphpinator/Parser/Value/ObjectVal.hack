namespace Graphpinator\Parser\Value;

final class ObjectVal extends \Graphpinator\Parser\Value\Value {

    public function __construct(
        int $id,
        \Graphpinator\Common\Location $location,
        private dict<string, Value> $value
    ) {
        parent::__construct($id, $location);
    }

    public function getValue(): dict<string, Value> {
        return $this->value;
    }
}
