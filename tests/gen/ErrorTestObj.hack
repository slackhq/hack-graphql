/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<1d4cf620c9b7b67489f9a5c895199816>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class ErrorTestObj extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'ErrorTestObj';
  const type THackType = \ErrorTestObj;
  const keyset<string> FIELD_NAMES = keyset[
    'bad_int_list_n_of_n',
    'bad_int_list_n_of_nn',
    'bad_int_list_nn_of_nn',
    'hidden_exception',
    'nested',
    'nested_list_n_of_n',
    'nested_list_n_of_nn',
    'nested_list_nn_of_nn',
    'nested_nn',
    'no_error',
    'non_nullable',
    'user_facing_error',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'bad_int_list_n_of_n':
        return new GraphQL\FieldDefinition(
          'bad_int_list_n_of_n',
          Types\IntType::nullableOutput()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->bad_int_list_n_of_n(),
          null,
          false,
          null,
        );
      case 'bad_int_list_n_of_nn':
        return new GraphQL\FieldDefinition(
          'bad_int_list_n_of_nn',
          Types\IntType::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->bad_int_list_n_of_nn(),
          'Nullability of nested types is respected, which may result in killing the whole list (but no parents)',
          false,
          null,
        );
      case 'bad_int_list_nn_of_nn':
        return new GraphQL\FieldDefinition(
          'bad_int_list_nn_of_nn',
          Types\IntType::nonNullable()->nonNullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->bad_int_list_nn_of_nn(),
          null,
          false,
          null,
        );
      case 'hidden_exception':
        return new GraphQL\FieldDefinition(
          'hidden_exception',
          Types\IntType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->hidden_exception(),
          'Arbitrary exceptions are hidden from clients, since they might contain sensitive data',
          false,
          null,
        );
      case 'nested':
        return new GraphQL\FieldDefinition(
          'nested',
          ErrorTestObj::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested(),
          null,
          false,
          null,
        );
      case 'nested_list_n_of_n':
        return new GraphQL\FieldDefinition(
          'nested_list_n_of_n',
          ErrorTestObj::nullableOutput()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested_list_n_of_n(),
          null,
          false,
          null,
        );
      case 'nested_list_n_of_nn':
        return new GraphQL\FieldDefinition(
          'nested_list_n_of_nn',
          ErrorTestObj::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested_list_n_of_nn(),
          null,
          false,
          null,
        );
      case 'nested_list_nn_of_nn':
        return new GraphQL\FieldDefinition(
          'nested_list_nn_of_nn',
          ErrorTestObj::nonNullable()->nonNullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested_list_nn_of_nn(),
          null,
          false,
          null,
        );
      case 'nested_nn':
        return new GraphQL\FieldDefinition(
          'nested_nn',
          ErrorTestObj::nonNullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested_nn(),
          null,
          false,
          null,
        );
      case 'no_error':
        return new GraphQL\FieldDefinition(
          'no_error',
          Types\IntType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->no_error(),
          null,
          false,
          null,
        );
      case 'non_nullable':
        return new GraphQL\FieldDefinition(
          'non_nullable',
          Types\IntType::nonNullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->non_nullable(),
          null,
          false,
          null,
        );
      case 'user_facing_error':
        return new GraphQL\FieldDefinition(
          'user_facing_error',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->user_facing_error(),
          null,
          false,
          null,
        );
      default:
        return null;
    }
  }
}
