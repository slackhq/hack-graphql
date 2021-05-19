/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<3126058d1cca936025d2913e93b3721a>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __Type extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__Type';
  const type THackType = \Slack\GraphQL\Introspection\V2\__Type;
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
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getDescription(),
        );
      case 'enumValues':
        return new GraphQL\FieldDefinition(
          'enumValues',
          __EnumValue::nonNullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> $parent->getEnumValues(),
        );
      case 'fields':
        return new GraphQL\FieldDefinition(
          'fields',
          __Field::nonNullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> $parent->getFields(),
        );
      case 'inputFields':
        return new GraphQL\FieldDefinition(
          'inputFields',
          __InputValue::nonNullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> $parent->getInputFields(),
        );
      case 'interfaces':
        return new GraphQL\FieldDefinition(
          'interfaces',
          __Type::nonNullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> $parent->getInterfaces(),
        );
      case 'kind':
        return new GraphQL\FieldDefinition(
          'kind',
          __TypeKindOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getKind(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'ofType':
        return new GraphQL\FieldDefinition(
          'ofType',
          __Type::nullable(),
          async ($parent, $args, $vars) ==> $parent->getOfType(),
        );
      case 'possibleTypes':
        return new GraphQL\FieldDefinition(
          'possibleTypes',
          __Type::nonNullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> $parent->getPossibleTypes(),
        );
      default:
        return null;
    }
  }
}
