/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<4f448f84ae5cc678a2e9ee3756e13c46>>
 */
namespace Slack\GraphQL\Test\Generated\Introspection;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Introspection;

final class __InputValue extends \Slack\GraphQL\Introspection\V2\ObjectType {

  const NAME = '__InputValue';
  const ?string DESCRIPTION = null;

  <<__Override>>
  public function getFields(): vec<\Slack\GraphQL\Introspection\V2\__Field> {
    return vec[
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'defaultValue',
        Introspection\V2\StringType::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'description',
        Introspection\V2\StringType::nullable(),
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
