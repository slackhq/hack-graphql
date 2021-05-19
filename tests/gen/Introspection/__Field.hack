/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<65490aef814479a34b39d98f5e4c0442>>
 */
namespace Slack\GraphQL\Test\Generated\Introspection;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Introspection;

final class __Field extends \Slack\GraphQL\Introspection\V2\ObjectType {

  const NAME = '__Field';
  const ?string DESCRIPTION = null;

  <<__Override>>
  public function getFields(): vec<\Slack\GraphQL\Introspection\V2\__Field> {
    return vec[
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'args',
        __InputValue::nonNullable()->nullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'deprecationReason',
        Introspection\V2\StringType::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'description',
        Introspection\V2\StringType::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'isDeprecated',
        Introspection\V2\BooleanType::nonNullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'name',
        Introspection\V2\StringType::nonNullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'type',
        __Type::nullable(),
      )
      ,
    ];
  }
}
