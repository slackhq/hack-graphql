/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<bf2e2cfb2c04c61b3acc58f989e5d038>>
 */
namespace Slack\GraphQL\Test\Generated\Introspection;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Introspection;

final class __EnumValue extends \Slack\GraphQL\Introspection\V2\ObjectType {

  const NAME = '__EnumValue';
  const ?string DESCRIPTION = null;

  <<__Override>>
  public function getFields(): vec<\Slack\GraphQL\Introspection\V2\__Field> {
    return vec[
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
    ];
  }
}
