/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<ac823903c5f5fc11c96ac935e69385f6>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __EnumValue extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__EnumValue';
  const type THackType = \Slack\GraphQL\Introspection\__EnumValue;
  const keyset<string> FIELD_NAMES = keyset[
    'name',
    'description',
    'isDeprecated',
    'deprecationReason',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getDescription(),
        );
      case 'isDeprecated':
        return new GraphQL\FieldDefinition(
          'isDeprecated',
          Types\BooleanOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->isDeprecated(),
        );
      case 'deprecationReason':
        return new GraphQL\FieldDefinition(
          'deprecationReason',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getDeprecationReason(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}
