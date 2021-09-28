/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<fbf0199474a4b1b215782082ae1c2256>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class FooObject extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'FooObject';
  const type THackType = \Foo\FooObject;
  const keyset<string> FIELD_NAMES = keyset[
    'value',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
    'FooInterface' => FooInterface::class,
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
          vec[],
        );
      default:
        return null;
    }
  }

  public function getDirectives(): vec<GraphQL\ObjectDirective> {
    return vec[];
  }
}
