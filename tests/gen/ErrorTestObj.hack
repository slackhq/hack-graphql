/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<2bd9f28bf6c125e22dbf00bcb4b5ff6c>>
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

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'bad_int_list_n_of_n':
        return new GraphQL\FieldDefinition(
          'bad_int_list_n_of_n',
          Types\IntType::nullableOutput($this->schema)->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->bad_int_list_n_of_n(),
        );
      case 'bad_int_list_n_of_nn':
        return new GraphQL\FieldDefinition(
          'bad_int_list_n_of_nn',
          Types\IntType::nonNullable($this->schema)->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->bad_int_list_n_of_nn(),
        );
      case 'bad_int_list_nn_of_nn':
        return new GraphQL\FieldDefinition(
          'bad_int_list_nn_of_nn',
          Types\IntType::nonNullable($this->schema)->nonNullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->bad_int_list_nn_of_nn(),
        );
      case 'hidden_exception':
        return new GraphQL\FieldDefinition(
          'hidden_exception',
          Types\IntType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->hidden_exception(),
        );
      case 'nested':
        return new GraphQL\FieldDefinition(
          'nested',
          ErrorTestObj::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested(),
        );
      case 'nested_list_n_of_n':
        return new GraphQL\FieldDefinition(
          'nested_list_n_of_n',
          ErrorTestObj::nullableOutput($this->schema)->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested_list_n_of_n(),
        );
      case 'nested_list_n_of_nn':
        return new GraphQL\FieldDefinition(
          'nested_list_n_of_nn',
          ErrorTestObj::nonNullable($this->schema)->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested_list_n_of_nn(),
        );
      case 'nested_list_nn_of_nn':
        return new GraphQL\FieldDefinition(
          'nested_list_nn_of_nn',
          ErrorTestObj::nonNullable($this->schema)->nonNullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested_list_nn_of_nn(),
        );
      case 'nested_nn':
        return new GraphQL\FieldDefinition(
          'nested_nn',
          ErrorTestObj::nonNullable($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested_nn(),
        );
      case 'no_error':
        return new GraphQL\FieldDefinition(
          'no_error',
          Types\IntType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->no_error(),
        );
      case 'non_nullable':
        return new GraphQL\FieldDefinition(
          'non_nullable',
          Types\IntType::nonNullable($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->non_nullable(),
        );
      case 'user_facing_error':
        return new GraphQL\FieldDefinition(
          'user_facing_error',
          Types\StringType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->user_facing_error(),
        );
      default:
        return null;
    }
  }
}
