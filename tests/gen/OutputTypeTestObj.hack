/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<7c66631690dca9d26e83298fd9af017a>>
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
    'output_shape',
    'scalar',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'awaitable':
        return new GraphQL\FieldDefinition(
          'awaitable',
          Types\IntType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->awaitable(),
          null,
          null,
        );
      case 'awaitable_nullable':
        return new GraphQL\FieldDefinition(
          'awaitable_nullable',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->awaitable_nullable(),
          null,
          null,
        );
      case 'awaitable_nullable_list':
        return new GraphQL\FieldDefinition(
          'awaitable_nullable_list',
          Types\IntType::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->awaitable_nullable_list(),
          null,
          null,
        );
      case 'list':
        return new GraphQL\FieldDefinition(
          'list',
          Types\StringType::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->list(),
          null,
          null,
        );
      case 'nested_lists':
        return new GraphQL\FieldDefinition(
          'nested_lists',
          Types\IntType::nullableOutput()->nonNullableOutputListOf()->nullableOutputListOf()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested_lists(),
          'Note that nested lists can be non-nullable',
          null,
        );
      case 'nullable':
        return new GraphQL\FieldDefinition(
          'nullable',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nullable(),
          null,
          null,
        );
      case 'output_shape':
        return new GraphQL\FieldDefinition(
          'output_shape',
          OutputShape::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->output_shape(),
          null,
          null,
        );
      case 'scalar':
        return new GraphQL\FieldDefinition(
          'scalar',
          Types\IntType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->scalar(),
          'Note that the GraphQL field will be nullable by default, despite its non-nullable Hack type',
          null,
        );
      default:
        return null;
    }
  }
}
