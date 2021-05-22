/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<b746f756c5abd273a26f5ca35535fd0c>>
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
  const keyset<classname<Types\InterfaceType>> INTERFACES = keyset[
    IIntrospectionInterfaceA::class,
    IIntrospectionInterfaceB::class,
    IIntrospectionInterfaceC::class,
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
