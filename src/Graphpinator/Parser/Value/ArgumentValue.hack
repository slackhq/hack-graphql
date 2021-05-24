namespace Graphpinator\Parser\Value;


final class ArgumentValue extends \Graphpinator\Parser\Node {
    public function __construct(
        int $id,
        \Graphpinator\Common\Location $location,
        private string $name,
        private Value $value,
    ) {
        parent::__construct($id, $location);
    }

    public function getName(): string {
        return $this->name;
    }

    public function getValue(): Value {
        return $this->value;
    }
}