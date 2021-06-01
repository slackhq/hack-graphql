/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<46725fb0d0175c7f30579a28e030cf3b>>
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
        );
      case 'inputFields':
        return new GraphQL\FieldDefinition(
          'inputFields',
          __InputValue::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionInputFields(),
        );
      case 'interfaces':
        return new GraphQL\FieldDefinition(
          'interfaces',
          __Type::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionInterfaces(),
        );
      case 'kind':
        return new GraphQL\FieldDefinition(
          'kind',
          __TypeKind::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionKind(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionName(),
        );
      case 'ofType':
        return new GraphQL\FieldDefinition(
          'ofType',
          __Type::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionOfType(),
        );
      case 'possibleTypes':
        return new GraphQL\FieldDefinition(
          'possibleTypes',
          __Type::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionPossibleTypes(),
        );
      default:
        return null;
    }
  }
}
