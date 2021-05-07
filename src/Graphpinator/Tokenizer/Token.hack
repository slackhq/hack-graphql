namespace Graphpinator\Tokenizer;

final class Token {
    private string $type;
    private ?string $value;
    private \Graphpinator\Common\Location $location;

    public function __construct(string $type, \Graphpinator\Common\Location $location, ?string $value = null) {
        $this->type = $type;
        $this->value = $value;
        $this->location = $location;
    }

    public function getType(): string {
        return $this->type;
    }

    public function getValue(): ?string {
        return $this->value;
    }

    public function getLocation(): \Graphpinator\Common\Location {
        return $this->location;
    }
}
