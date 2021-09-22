/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<79cc4c1ea40dd63c7dfe85f7089e9fb2>>
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
    'isDeprecated',
    'description',
    'deprecationReason',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['name'],
          null,
          null,
        );
      case 'isDeprecated':
        return new GraphQL\FieldDefinition(
          'isDeprecated',
          Types\BooleanType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['isDeprecated'],
          null,
          null,
        );
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['description'] ?? null,
          null,
          null,
        );
      case 'deprecationReason':
        return new GraphQL\FieldDefinition(
          'deprecationReason',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['deprecationReason'] ?? null,
          null,
          null,
        );
      default:
        return null;
    }
  }
}
