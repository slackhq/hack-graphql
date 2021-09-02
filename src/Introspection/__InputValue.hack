
namespace Slack\GraphQL\Introspection;

use namespace Slack\GraphQL;

<<GraphQL\ObjectType('__InputValue', 'Input value introspection')>>
type __InputValue = shape(
    'name' => string,
    ?'description' => ?string,
    'type' => __Type,
    ?'defaultValue' => ?string,
);
