namespace Graphpinator\Parser\Value;

final class ArgumentValue {

    public function __construct(private \Graphpinator\Parser\Value\Value $value, private string $name) {}

    public function getValue(): \Graphpinator\Parser\Value\Value {
        return $this->value;
    }

    public function getName(): string {
        return $this->name;
    }
}
