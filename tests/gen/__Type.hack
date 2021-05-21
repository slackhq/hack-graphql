/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<77e01be885fdc912d3a02a656f650d66>>
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
          Types\StringType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionDescription(),
        );
      case 'enumValues':
        return new GraphQL\FieldDefinition(
          'enumValues',
          __EnumValue::nonNullable($this->schema)->nullableOutputListOf(),
          dict[
            'include_deprecated' => shape(
              'name' => 'include_deprecated',
              'type' => Types\BooleanType::nonNullable($this->schema),
              'default_value' => false,
            ),
          ],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionEnumValues(
            Types\BooleanType::nonNullable($this->schema)->coerceOptionalNamedNode('include_deprecated', $args, $vars, false),
          ),
        );
      case 'fields':
        return new GraphQL\FieldDefinition(
          'fields',
          __Field::nonNullable($this->schema)->nullableOutputListOf(),
          dict[
            'include_deprecated' => shape(
              'name' => 'include_deprecated',
              'type' => Types\BooleanType::nonNullable($this->schema),
              'default_value' => false,
            ),
          ],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionFields(
            Types\BooleanType::nonNullable($this->schema)->coerceOptionalNamedNode('include_deprecated', $args, $vars, false),
          ),
        );
      case 'inputFields':
        return new GraphQL\FieldDefinition(
          'inputFields',
          __InputValue::nonNullable($this->schema)->nullableOutputListOf(),
          dict[
            'include_deprecated' => shape(
              'name' => 'include_deprecated',
              'type' => Types\BooleanType::nonNullable($this->schema),
              'default_value' => false,
            ),
          ],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionInputFields(
            Types\BooleanType::nonNullable($this->schema)->coerceOptionalNamedNode('include_deprecated', $args, $vars, false),
          ),
        );
      case 'interfaces':
        return new GraphQL\FieldDefinition(
          'interfaces',
          __Type::nonNullable($this->schema)->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionInterfaces(),
        );
      case 'kind':
        return new GraphQL\FieldDefinition(
          'kind',
          __TypeKind::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionKind(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionName(),
        );
      case 'ofType':
        return new GraphQL\FieldDefinition(
          'ofType',
          __Type::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionOfType(),
        );
      case 'possibleTypes':
        return new GraphQL\FieldDefinition(
          'possibleTypes',
          __Type::nonNullable($this->schema)->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionPossibleTypes(),
        );
      default:
        return null;
    }
  }
}
