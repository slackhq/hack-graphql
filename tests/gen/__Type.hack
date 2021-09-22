/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<48a05c7de06f421d045fa09aaa1da78e>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __Type extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__Type';
  const type THackType = \Slack\GraphQL\Introspection\__Type;
  const keyset<string> FIELD_NAMES = keyset[
    'description',
    'enumValues',
    'fields',
    'inputFields',
    'interfaces',
    'kind',
    'name',
    'ofType',
    'possibleTypes',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionDescription(),
          'Description of the type',
          false,
          null,
        );
      case 'enumValues':
        return new GraphQL\FieldDefinition(
          'enumValues',
          __EnumValue::nonNullable()->nullableOutputListOf(),
          dict[
            'includeDeprecated' => shape(
              'name' => 'includeDeprecated',
              'type' => Types\BooleanType::nonNullable(),
              'defaultValue' => 'false',
            ),
          ],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionEnumValues(
            Types\BooleanType::nonNullable()->coerceOptionalNamedNode('includeDeprecated', $args, $vars, false),
          ),
          'Enum values, only applies to ENUM',
          false,
          null,
        );
      case 'fields':
        return new GraphQL\FieldDefinition(
          'fields',
          __Field::nonNullable()->nullableOutputListOf(),
          dict[
            'includeDeprecated' => shape(
              'name' => 'includeDeprecated',
              'type' => Types\BooleanType::nonNullable(),
              'defaultValue' => 'false',
            ),
          ],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionFields(
            Types\BooleanType::nonNullable()->coerceOptionalNamedNode('includeDeprecated', $args, $vars, false),
          ),
          'Fields of the type, only applies to OBJECT and INTERFACE',
          false,
          null,
        );
      case 'inputFields':
        return new GraphQL\FieldDefinition(
          'inputFields',
          __InputValue::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionInputFields(),
          'Input fields, only applies to INPUT_OBJECT',
          false,
          null,
        );
      case 'interfaces':
        return new GraphQL\FieldDefinition(
          'interfaces',
          __Type::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionInterfaces(),
          'Interfaces the object implements, only applies to OBJECT',
          false,
          null,
        );
      case 'kind':
        return new GraphQL\FieldDefinition(
          'kind',
          __TypeKind::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionKind(),
          'Kind of the type',
          false,
          null,
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionName(),
          'Name of the type',
          false,
          null,
        );
      case 'ofType':
        return new GraphQL\FieldDefinition(
          'ofType',
          __Type::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionOfType(),
          'Underlying wrapped type, only applies to NON_NULL and LIST',
          false,
          null,
        );
      case 'possibleTypes':
        return new GraphQL\FieldDefinition(
          'possibleTypes',
          __Type::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionPossibleTypes(),
          'Possible types that implement this interface, only applies to INTERFACE',
          false,
          null,
        );
      default:
        return null;
    }
  }
}
