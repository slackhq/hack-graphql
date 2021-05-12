namespace Slack\GraphQL;


final class EnumType implements \HH\EnumAttribute {
    public function __construct(private string $type, private string $description) {}

    public function getType(): string {
        return $this->type;
    }

    public function getInputType(): string {
        return $this->getType().'InputType';
    }

    public function getOutputType(): string {
        return $this->getType().'OutputType';
    }
}