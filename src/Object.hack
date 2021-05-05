namespace Slack\GraphQL;

class Object implements \HH\ClassAttribute {
    public function __construct(private string $type, private string $description) {}
}
