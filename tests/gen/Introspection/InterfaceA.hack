/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<c3f4977ba3ca32376d0e8a7175a15d11>>
 */
namespace Slack\GraphQL\Test\Generated\Introspection;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Introspection;

final class InterfaceA extends \Slack\GraphQL\Introspection\V2\ObjectType {

  const NAME = 'InterfaceA';
  const ?string DESCRIPTION = null;

  <<__Override>>
  public function getFields(): vec<\Slack\GraphQL\Introspection\V2\__Field> {
    return vec[
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'foo',
        Introspection\V2\StringType::nonNullable(),
      )
      ,
    ];
  }
}
