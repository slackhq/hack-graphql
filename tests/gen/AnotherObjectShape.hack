/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<606043d082f96b545453067bc58eb77e>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class AnotherObjectShape extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'AnotherObjectShape';
  const type THackType = \AnotherObjectShape;
  const keyset<string> FIELD_NAMES = keyset[
    'abc',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'abc':
        return new GraphQL\FieldDefinition(
          'abc',
          Types\IntOutputType::nonNullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> $parent['abc'],
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}
