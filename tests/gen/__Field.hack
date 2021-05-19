/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<d73ddc45caada283bd311b1c3c62fd4e>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __Field extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__Field';
  const type THackType = \Slack\GraphQL\Introspection\V2\__Field;
  const keyset<string> FIELD_NAMES = keyset[
    'args',
    'deprecationReason',
    'description',
    'isDeprecated',
    'name',
    'type',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'args':
        return new GraphQL\FieldDefinition(
          'args',
          __InputValue::nonNullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> $parent->getArgs(),
        );
      case 'deprecationReason':
        return new GraphQL\FieldDefinition(
          'deprecationReason',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getDeprecationReason(),
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
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'type':
        return new GraphQL\FieldDefinition(
          'type',
          __Type::nullable(),
          async ($parent, $args, $vars) ==> $parent->getType(),
        );
      default:
        return null;
    }
  }
}
