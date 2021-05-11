namespace Slack\GraphQL;


final class EnumType implements \HH\EnumAttribute {
    public function __construct(private string $type, private string $description) {}

    public function getType(): string {
        return $this->type;
    }

    public function getOutputType(): string {
        return $this->getType().'OutputType';
    }
}