/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<4ee05a200f698afc8c2432c2a1b97359>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class ObjectShape extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'ObjectShape';
  const type THackType = \ObjectShape;
  const keyset<string> FIELD_NAMES = keyset[
    'foo',
    'bar',
    'baz',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'foo':
        return new GraphQL\FieldDefinition(
          'foo',
          Types\IntType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['foo'],
        );
      case 'bar':
        return new GraphQL\FieldDefinition(
          'bar',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['bar'] ?? null,
        );
      case 'baz':
        return new GraphQL\FieldDefinition(
          'baz',
          AnotherObjectShape::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['baz'],
        );
      default:
        return null;
    }
  }
}
