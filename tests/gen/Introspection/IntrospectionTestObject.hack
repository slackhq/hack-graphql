/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<0af0fb9cc77f91324e4397dfa70dc2f8>>
 */
namespace Slack\GraphQL\Test\Generated\Introspection;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Introspection;

final class IntrospectionTestObject
  extends \Slack\GraphQL\Introspection\V2\ObjectType {

  const NAME = 'IntrospectionTestObject';
  const ?string DESCRIPTION = null;

  <<__Override>>
  public function getFields(): vec<\Slack\GraphQL\Introspection\V2\__Field> {
    return vec[
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'default_list_of_non_nullable_int',
        Introspection\V2\IntType::nonNullable()->nonNullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'default_list_of_nullable_int',
        Introspection\V2\IntType::nullable()->nonNullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'default_nullable_string',
        Introspection\V2\StringType::nonNullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'non_null_int',
        Introspection\V2\IntType::nonNullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'non_null_list_of_non_null',
        Introspection\V2\IntType::nonNullable()->nonNullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'non_null_string',
        Introspection\V2\StringType::nonNullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'nullable_string',
        Introspection\V2\StringType::nullable(),
      )
      ,
    ];
  }
}
