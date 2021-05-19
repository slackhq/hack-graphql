/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<3df696bb111a4e5dbf0df636de065d57>>
 */
namespace Slack\GraphQL\Test\Generated\Introspection;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Introspection;

final class User extends \Slack\GraphQL\Introspection\V2\ObjectType {

  const NAME = 'User';
  const ?string DESCRIPTION = null;

  <<__Override>>
  public function getFields(): vec<\Slack\GraphQL\Introspection\V2\__Field> {
    return vec[
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'id',
        Introspection\V2\IntType::nonNullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'is_active',
        Introspection\V2\BooleanType::nonNullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'name',
        Introspection\V2\StringType::nonNullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'team',
        Team::nullable(),
      )
      ,
    ];
  }
}
