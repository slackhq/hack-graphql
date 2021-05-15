/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<6598700c758a0e6fae58a95f126303a9>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class InterfaceB extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'InterfaceB';
  const type THackType = \InterfaceB;
  const keyset<string> FIELD_NAMES = keyset[
    'bar',
    'foo',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'bar':
        return new GraphQL\FieldDefinition(
          'bar',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->bar(),
        );
      case 'foo':
        return new GraphQL\FieldDefinition(
          'foo',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->foo(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}
