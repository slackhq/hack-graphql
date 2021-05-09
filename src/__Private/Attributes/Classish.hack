namespace Slack\GraphQL\__Private;

class Classish implements \HH\ClassAttribute {
    public function __construct(private string $type, private string $description) {}

    public function getType(): string {
        return $this->type;
    }
}
