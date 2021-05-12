namespace Slack\GraphQL;

/**
* GraphQL input type: https://graphql.org/learn/schema/#input-types
*
* Annotate shapes with this attribute to support accepting them as inputs within
* mutations.
*/
class InputType implements \HH\TypeAliasAttribute {
    public function __construct(private string $type, private string $description) {}

    public function getType(): string {
        return $this->type;
    }
}
