namespace Slack\GraphQL;

interface Directive {}

interface FieldDirective extends Directive, \HH\MethodAttribute {}