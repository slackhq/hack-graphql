namespace Slack\GraphQL;

class Field implements \HH\MethodAttribute {
    public function __construct(private string $name, private string $description) {}
}
