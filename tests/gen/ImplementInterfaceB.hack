/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<9e0b3a4ffca4c305b94da9212f5b4b6f>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class ImplementInterfaceB extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'ImplementInterfaceB';
  const type THackType = \ImplementInterfaceB;
  const keyset<string> FIELD_NAMES = keyset[
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
    'IIntrospectionInterfaceA' => IIntrospectionInterfaceA::class,
    'IIntrospectionInterfaceB' => IIntrospectionInterfaceB::class,
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      default:
        return null;
    }
  }
}
