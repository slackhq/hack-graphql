namespace Graphpinator\Parser\Value;

final class EnumLiteral extends \Graphpinator\Parser\Value\Value {

    public function __construct(int $id, \Graphpinator\Common\Location $location, private string $value) {
        parent::__construct($id, $location);
    }

    public function getRawValue(): string {
        return $this->value;
    }
}
