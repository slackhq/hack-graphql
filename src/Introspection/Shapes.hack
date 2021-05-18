namespace Slack\GraphQL\Introspection;

use namespace Slack\GraphQL;

<<GraphQL\ObjectType('__Directive', '')>>
type __Directive = shape(
  'name' => string,
  ?'description' => ?string,
  'locations' => vec<__DirectiveLocation>,
  'args' => vec<__InputValue>,
  'isRepeatable' => bool,
);

<<GraphQL\ObjectType('__EnumValue', '')>>
type __EnumValue = shape(
  'name' => string,
  ?'description' => ?string,
  'isDeprecated' => bool,
  ?'deprecationReason' => ?string,
);

<<GraphQL\ObjectType('__Field', '')>>
type __Field = shape(
  'name' => string,
  ?'description' => ?string,
  'args' => vec<__InputValue>,
  'type' => __Type,
  'isDeprecated' => bool,
  ?'deprecationReason' => ?string,
);

<<GraphQL\ObjectType('__InputValue', '')>>
type __InputValue = shape(
  'name' => string,
  ?'description' => ?string,
  'type' => __Type,
  ?'defaultValue' => ?string,
);
