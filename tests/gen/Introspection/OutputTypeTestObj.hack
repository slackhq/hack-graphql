/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<198de83ac7785201a89a0e5760acc36d>>
 */
namespace Slack\GraphQL\Test\Generated\Introspection;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Introspection;

final class OutputTypeTestObj
  extends \Slack\GraphQL\Introspection\V2\ObjectType {

  const NAME = 'OutputTypeTestObj';
  const ?string DESCRIPTION = null;

  <<__Override>>
  public function getFields(): vec<\Slack\GraphQL\Introspection\V2\__Field> {
    return vec[
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'awaitable',
        Types\IntOutputType::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'awaitable_nullable',
        Types\StringOutputType::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'awaitable_nullable_list',
        Types\IntOutputType::nonNullable()->nullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'list',
        Introspection\V2\StringType::nonNullable()->nonNullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'nested_lists',
        Introspection\V2\IntType::nullable()->nonNullableListOf()->nullableListOf()->nonNullableListOf(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'nullable',
        Introspection\V2\StringType::nullable(),
      )
      ,
      \Slack\GraphQL\Introspection\V2\__Field::for(
        'scalar',
        Introspection\V2\IntType::nonNullable(),
      )
      ,
    ];
  }
}
