namespace Slack\GraphQL;

interface Directive {}

interface FieldDirective extends Directive, \HH\MethodAttribute {
    public function beforeResolve(IFieldDefinition $field): Awaitable<void>;
}