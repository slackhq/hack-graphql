/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<f6a3c3d9aea3d8a7180f03a7d77ed3d0>>
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
    'fields',
    'kind',
    'name',
    'ofType',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getDescription(),
        );
      case 'fields':
        return new GraphQL\FieldDefinition(
          'fields',
          __Field::nonNullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getFields(),
        );
      case 'kind':
        return new GraphQL\FieldDefinition(
          'kind',
          __TypeKindOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getKind(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'ofType':
        return new GraphQL\FieldDefinition(
          'ofType',
          __Type::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getOfType(),
        );
      default:
        return null;
    }
  }
}
