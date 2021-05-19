/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<e6ee1e96f84f893bc905f00d5aa63ee5>>
 */
namespace Slack\GraphQL\Test\Generated\Introspection;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Introspection;

final class __Type extends \Slack\GraphQL\Introspection\V2\ObjectType {

  const NAME = '__Type';
  const ?string DESCRIPTION = null;

  <<__Override>>
  public function getFields(): vec<\Slack\GraphQL\Introspection\V2\__Field> {
    return vec[
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'description',
        Introspection\V2\StringType::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'enumValues',
        __EnumValue::nonNullable()->nullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'fields',
        __Field::nonNullable()->nullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'inputFields',
        __InputValue::nonNullable()->nullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'interfaces',
        __Type::nonNullable()->nullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'kind',
        __TypeKindOutputType::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'name',
        Introspection\V2\StringType::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'ofType',
        __Type::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'possibleTypes',
        __Type::nonNullable()->nullableListOf(),
      )
      ,
    ];
  }
}
