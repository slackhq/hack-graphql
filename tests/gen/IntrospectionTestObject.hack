/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<93ec72ecc482e1cdffed6c2cee788a99>>
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
    'deprecated_field',
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
          'Default list of non nullable int',
          null,
        );
      case 'default_list_of_nullable_int':
        return new GraphQL\FieldDefinition(
          'default_list_of_nullable_int',
          Types\IntType::nullableOutput()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getDefaultListOfNullableInt(),
          'Default list of nullable int',
          null,
        );
      case 'default_nullable_string':
        return new GraphQL\FieldDefinition(
          'default_nullable_string',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getDefaultNullableString(),
          'Default nullable string',
          null,
        );
      case 'deprecated_field':
        return new GraphQL\FieldDefinition(
          'deprecated_field',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> /* HH_FIXME[4128] Deprecated */ $parent->getDeprecated(),
          'Deprecated field',
          'Deprecated for testing',
        );
      case 'non_null_int':
        return new GraphQL\FieldDefinition(
          'non_null_int',
          Types\IntType::nonNullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getNonNullInt(),
          'Non nullable int',
          null,
        );
      case 'non_null_list_of_non_null':
        return new GraphQL\FieldDefinition(
          'non_null_list_of_non_null',
          Types\IntType::nonNullable()->nonNullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getNonNullListOfNonNull(),
          'Non nullable list of non nullables',
          null,
        );
      case 'non_null_string':
        return new GraphQL\FieldDefinition(
          'non_null_string',
          Types\StringType::nonNullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getNonNullString(),
          'Non nullable string',
          null,
        );
      case 'nullable_string':
        return new GraphQL\FieldDefinition(
          'nullable_string',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getNullableString(),
          'Nullable string',
          null,
        );
      default:
        return null;
    }
  }
}
