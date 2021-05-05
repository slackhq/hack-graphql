namespace Slack\GraphQL;

class QueryRootField implements \HH\MethodAttribute {
    public function __construct(private string $name, private string $description) {}
}
