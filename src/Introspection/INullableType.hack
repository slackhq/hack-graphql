namespace Slack\GraphQL\Introspection;

interface INullableType {
    public function getInnerType(): __Type;
}
