/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<acb91961ac1a6972c2eaebe1b9baba67>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class FooObject extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'FooObject';
  const type THackType = \Foo\FooObject;
  const keyset<string> FIELD_NAMES = keyset[
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
    'FooInterface' => FooInterface::class,
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      default:
        return null;
    }
  }

  public function getDirectives(): vec<GraphQL\ObjectDirective> {
    return vec[];
  }
}
