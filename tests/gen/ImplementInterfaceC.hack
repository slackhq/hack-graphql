/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<11aa39f80b2881d293b3ecfb2c300565>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class ImplementInterfaceC extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'ImplementInterfaceC';
  const type THackType = \ImplementInterfaceC;
  const keyset<string> FIELD_NAMES = keyset[
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
    'IIntrospectionInterfaceA' => IIntrospectionInterfaceA::class,
    'IIntrospectionInterfaceB' => IIntrospectionInterfaceB::class,
    'IIntrospectionInterfaceC' => IIntrospectionInterfaceC::class,
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
