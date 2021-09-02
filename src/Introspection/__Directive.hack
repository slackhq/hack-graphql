


namespace Slack\GraphQL\Introspection;

use namespace Slack\GraphQL;

// TODO: This should probably be an interface,
// but keeping as is until we support custom directives as this is adequate.
<<GraphQL\ObjectType('__Directive', 'Directive introspection')>>
type __Directive = shape(
    'name' => string,
    'description' => ?string,
    'locations' => vec<string>,
    'args' => vec<__InputValue>,
);
