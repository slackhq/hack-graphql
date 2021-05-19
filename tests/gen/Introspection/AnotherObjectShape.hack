/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<83da9444b49e111ae8b9f8b758990c41>>
 */
namespace Slack\GraphQL\Test\Generated\Introspection;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Introspection;

final class AnotherObjectShape
  extends \Slack\GraphQL\Introspection\V2\ObjectType {

  const NAME = 'AnotherObjectShape';
  const ?string DESCRIPTION = null;

  <<__Override>>
  public function getFields(): vec<\Slack\GraphQL\Introspection\V2\__Field> {
    return vec[
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'abc',
        Introspection\V2\IntType::nonNullable()->nonNullableListOf(),
      )
      ,
    ];
  }
}
