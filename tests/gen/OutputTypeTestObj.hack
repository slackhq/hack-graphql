/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<3e965c545c8823734f324bf821aa4f9c>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class OutputTypeTestObj extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'OutputTypeTestObj';
  const type THackType = \OutputTypeTestObj;
  const keyset<string> FIELD_NAMES = keyset[
    'awaitable',
    'awaitable_nullable',
    'awaitable_nullable_list',
    'list',
    'nested_lists',
    'nullable',
    'scalar',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'awaitable':
        return new GraphQL\FieldDefinition(
          'awaitable',
          Types\IntOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->awaitable(),
        );
      case 'awaitable_nullable':
        return new GraphQL\FieldDefinition(
          'awaitable_nullable',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->awaitable_nullable(),
        );
      case 'awaitable_nullable_list':
        return new GraphQL\FieldDefinition(
          'awaitable_nullable_list',
          Types\IntOutputType::nonNullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->awaitable_nullable_list(),
        );
      case 'list':
        return new GraphQL\FieldDefinition(
          'list',
          Types\StringOutputType::nonNullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->list(),
        );
      case 'nested_lists':
        return new GraphQL\FieldDefinition(
          'nested_lists',
          Types\IntOutputType::nullable()->nonNullableListOf()->nullableListOf()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested_lists(),
        );
      case 'nullable':
        return new GraphQL\FieldDefinition(
          'nullable',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nullable(),
        );
      case 'scalar':
        return new GraphQL\FieldDefinition(
          'scalar',
          Types\IntOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->scalar(),
        );
      default:
        return null;
    }
  }
}
