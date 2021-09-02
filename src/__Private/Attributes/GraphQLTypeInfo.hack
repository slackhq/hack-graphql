
namespace Slack\GraphQL\__Private;


class GraphQLTypeInfo {
    public function __construct(private string $type, private string $description) {}

    final public function getType(): string {
        return $this->type;
    }

    final public function getDescription(): string {
        return $this->description;
    }
}
