/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<6e47b1eb223e0b6d700b68bde66186b7>>
 */
namespace Slack\GraphQL\Test\Generated\Introspection;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Introspection;

final class ErrorTestObj extends \Slack\GraphQL\Introspection\V2\ObjectType {

  const NAME = 'ErrorTestObj';
  const ?string DESCRIPTION = null;

  <<__Override>>
  public function getFields(): vec<\Slack\GraphQL\Introspection\V2\__Field> {
    return vec[
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'bad_int_list_n_of_n',
        Introspection\V2\IntType::nullable()->nonNullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'bad_int_list_n_of_nn',
        Introspection\V2\IntType::nonNullable()->nonNullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'bad_int_list_nn_of_nn',
        Introspection\V2\IntType::nonNullable()->nonNullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'hidden_exception',
        Introspection\V2\IntType::nonNullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'nested',
        ErrorTestObj::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'nested_list_n_of_n',
        ErrorTestObj::nullable()->nullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'nested_list_n_of_nn',
        ErrorTestObj::nonNullable()->nullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'nested_list_nn_of_nn',
        ErrorTestObj::nonNullable()->nullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'nested_nn',
        ErrorTestObj::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'no_error',
        Introspection\V2\IntType::nonNullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'non_nullable',
        Introspection\V2\IntType::nonNullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'user_facing_error',
        Introspection\V2\StringType::nullable(),
      )
      ,
    ];
  }
}
