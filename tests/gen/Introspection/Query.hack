/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<1f66768b87f68dca1a6426ea5c1fb639>>
 */
namespace Slack\GraphQL\Test\Generated\Introspection;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Introspection;

final class Query extends \Slack\GraphQL\Introspection\V2\ObjectType {

  const NAME = 'Query';
  const ?string DESCRIPTION = null;

  <<__Override>>
  public function getFields(): vec<\Slack\GraphQL\Introspection\V2\__Field> {
    return vec[
      \Slack\GraphQL\Introspection\V2\__Field::for(
        '__schema',
        __Schema::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        '__type',
        __Type::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'arg_test',
        Introspection\V2\IntType::nullable()->nonNullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'bot',
        Bot::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'error_test',
        ErrorTestObj::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'error_test_nn',
        ErrorTestObj::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'getConcrete',
        Concrete::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'getInterfaceA',
        InterfaceA::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'getInterfaceB',
        InterfaceB::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'getObjectShape',
        ObjectShape::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'human',
        Human::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'introspection_test',
        IntrospectionTestObject::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'list_arg_test',
        Introspection\V2\IntType::nonNullable()->nullableListOf()->nullableListOf()->nullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'nested_list_sum',
        Introspection\V2\IntType::nonNullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'optional_field_test',
        Introspection\V2\StringType::nonNullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'output_type_test',
        OutputTypeTestObj::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'takes_favorite_color',
        Introspection\V2\BooleanType::nonNullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'user',
        User::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'viewer',
        User::nullable(),
      )
      ,
    ];
  }
}
