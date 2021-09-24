namespace Directives;

final class HasRole implements \Slack\GraphQL\FieldDirective {
    public function __construct(private vec<string> $roles) {}
}