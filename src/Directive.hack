


namespace Slack\GraphQL;

interface Directive {}

interface FieldDirective extends Directive, \HH\MethodAttribute {
    public function beforeResolveField(IFieldDefinition $field): Awaitable<void>;
}

interface ObjectDirective extends Directive, \HH\ClassAttribute {
    public function beforeResolveObject(): Awaitable<void>;
}
