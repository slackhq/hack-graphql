/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<96d26624e992a9825611f6456287747c>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class IntrospectionTestObject extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'IntrospectionTestObject';
  const type THackType = \IntrospectionTestObject;
  const keyset<string> FIELD_NAMES = keyset[
    'default_list_of_non_nullable_int',
    'default_list_of_nullable_int',
    'default_nullable_string',
    'non_null_int',
    'non_null_list_of_non_null',
    'non_null_string',
    'nullable_string',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'default_list_of_non_nullable_int':
        return new GraphQL\FieldDefinition(
          'default_list_of_non_nullable_int',
          Types\IntType::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getDefaultListOfNonNullableInt(),
          vec[],
        );
      case 'default_list_of_nullable_int':
        return new GraphQL\FieldDefinition(
          'default_list_of_nullable_int',
          Types\IntType::nullableOutput()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getDefaultListOfNullableInt(),
          vec[],
        );
      case 'default_nullable_string':
        return new GraphQL\FieldDefinition(
          'default_nullable_string',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getDefaultNullableString(),
          vec[],
        );
      case 'non_null_int':
        return new GraphQL\FieldDefinition(
          'non_null_int',
          Types\IntType::nonNullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getNonNullInt(),
          vec[],
        );
      case 'non_null_list_of_non_null':
        return new GraphQL\FieldDefinition(
          'non_null_list_of_non_null',
          Types\IntType::nonNullable()->nonNullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getNonNullListOfNonNull(),
          vec[],
        );
      case 'non_null_string':
        return new GraphQL\FieldDefinition(
          'non_null_string',
          Types\StringType::nonNullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getNonNullString(),
          vec[],
        );
      case 'nullable_string':
        return new GraphQL\FieldDefinition(
          'nullable_string',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getNullableString(),
          vec[],
        );
      default:
        return null;
    }
  }
}
