namespace Slack\GraphQL\Introspection;

interface IHasInnerType {
    protected function getInnerType(): __Type;
}
