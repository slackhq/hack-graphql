


namespace Slack\GraphQL\Introspection;

use namespace Slack\GraphQL;

<<GraphQL\ObjectType('__EnumValue', 'Enum value introspection')>>
type __EnumValue = shape(
    'name' => string,
    'isDeprecated' => bool,
    ?'description' => string,
    ?'deprecationReason' => string,
);
