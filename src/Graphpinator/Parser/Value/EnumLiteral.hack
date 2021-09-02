
namespace Graphpinator\Parser\Value;

final class EnumLiteral extends \Graphpinator\Parser\Value\Value {

    public function __construct(\Graphpinator\Common\Location $location, private string $value) {
        parent::__construct($location);
    }

    public function getRawValue(): string {
        return $this->value;
    }
}
