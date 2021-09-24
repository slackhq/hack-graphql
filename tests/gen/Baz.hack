/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<78317f3a7332839455ecbea5da091009>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Baz extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Baz';
  const type THackType = \Foo\Bar\Baz;
  const keyset<string> FIELD_NAMES = keyset[
    'value',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'value':
        return new GraphQL\FieldDefinition(
          'value',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getValue(),
        );
      default:
        return null;
    }
  }
}
