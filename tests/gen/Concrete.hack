/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<af8fe403ed18a3e1841c169a94b80577>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Concrete extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Concrete';
  const type THackType = \Concrete;
  const keyset<string> FIELD_NAMES = keyset[
    'bar',
    'baz',
    'foo',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
    'InterfaceA' => InterfaceA::class,
    'InterfaceB' => InterfaceB::class,
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'bar':
        return new GraphQL\FieldDefinition(
          'bar',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->bar(),
          'bar',
          null,
        );
      case 'baz':
        return new GraphQL\FieldDefinition(
          'baz',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->baz(),
          'baz',
          null,
        );
      case 'foo':
        return new GraphQL\FieldDefinition(
          'foo',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->foo(),
          'foo',
          null,
        );
      default:
        return null;
    }
  }
}
