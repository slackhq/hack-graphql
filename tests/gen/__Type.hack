/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<93805d647b2da8a6efdee2799c140370>>
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

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringType::nullableO(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionDescription(),
        );
      case 'enumValues':
        return new GraphQL\FieldDefinition(
          'enumValues',
          __EnumValue::nonNullable()->nullableListOfO(),
          dict[
            'include_deprecated' => shape(
              'name' => 'include_deprecated',
              'type' => Types\BooleanType::nonNullable(),
              'default_value' => false,
            ),
          ],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionEnumValues(
            Types\BooleanType::nonNullable()->coerceOptionalNamedNode('include_deprecated', $args, $vars, false),
          ),
        );
      case 'fields':
        return new GraphQL\FieldDefinition(
          'fields',
          __Field::nonNullable()->nullableListOfO(),
          dict[
            'include_deprecated' => shape(
              'name' => 'include_deprecated',
              'type' => Types\BooleanType::nonNullable(),
              'default_value' => false,
            ),
          ],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionFields(
            Types\BooleanType::nonNullable()->coerceOptionalNamedNode('include_deprecated', $args, $vars, false),
          ),
        );
      case 'inputFields':
        return new GraphQL\FieldDefinition(
          'inputFields',
          __InputValue::nonNullable()->nullableListOfO(),
          dict[
            'include_deprecated' => shape(
              'name' => 'include_deprecated',
              'type' => Types\BooleanType::nonNullable(),
              'default_value' => false,
            ),
          ],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionInputFields(
            Types\BooleanType::nonNullable()->coerceOptionalNamedNode('include_deprecated', $args, $vars, false),
          ),
        );
      case 'interfaces':
        return new GraphQL\FieldDefinition(
          'interfaces',
          __Type::nonNullable()->nullableListOfO(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionInterfaces(),
        );
      case 'kind':
        return new GraphQL\FieldDefinition(
          'kind',
          __TypeKind::nullableO(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionKind(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringType::nullableO(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionName(),
        );
      case 'ofType':
        return new GraphQL\FieldDefinition(
          'ofType',
          __Type::nullableO(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionOfType(),
        );
      case 'possibleTypes':
        return new GraphQL\FieldDefinition(
          'possibleTypes',
          __Type::nonNullable()->nullableListOfO(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionPossibleTypes(),
        );
      default:
        return null;
    }
  }
}
