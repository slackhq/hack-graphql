namespace Slack\GraphQL\__Private;

class CompositeType implements \HH\ClassAttribute, \HH\TypeAliasAttribute {
    public function __construct(private string $type, private string $description) {}

    public function getType(): string {
        return $this->type;
    }
}
