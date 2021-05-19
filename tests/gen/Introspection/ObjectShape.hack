/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<5eec91ca2481f5b92a62c40c043a24c5>>
 */
namespace Slack\GraphQL\Test\Generated\Introspection;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Introspection;

final class ObjectShape extends \Slack\GraphQL\Introspection\V2\ObjectType {

  const NAME = 'ObjectShape';
  const ?string DESCRIPTION = null;

  <<__Override>>
  public function getFields(): vec<\Slack\GraphQL\Introspection\V2\__Field> {
    return vec[
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'foo',
        Introspection\V2\IntType::nonNullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'bar',
        Introspection\V2\StringType::nonNullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'baz',
        AnotherObjectShape::nullable(),
      )
      ,
    ];
  }
}
