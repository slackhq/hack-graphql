/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<b575fc08cde468db5953a5706ed6f4a5>>
 */
namespace Slack\GraphQL\Test\Generated\Introspection;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Introspection;

final class __Schema extends \Slack\GraphQL\Introspection\V2\ObjectType {

  const NAME = '__Schema';
  const ?string DESCRIPTION = null;

  <<__Override>>
  public function getFields(): vec<\Slack\GraphQL\Introspection\V2\__Field> {
    return vec[
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'mutationType',
        __Type::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'queryType',
        __Type::nullable(),
      )
      ,
    ];
  }
}
