/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<0a7523ee6b0a6cb5ffa1d88cc472e22a>>
 */
namespace Slack\GraphQL\Test\Generated\Introspection;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Introspection;

final class Mutation extends \Slack\GraphQL\Introspection\V2\ObjectType {

  const NAME = 'Mutation';
  const ?string DESCRIPTION = null;

  <<__Override>>
  public function getFields(): vec<\Slack\GraphQL\Introspection\V2\__Field> {
    return vec[
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'createUser',
        User::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'pokeUser',
        User::nullable(),
      )
      ,
    ];
  }
}
