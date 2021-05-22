/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<0b9e305b7922e55c884f72de5b268498>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class ImplementInterfaceA extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'ImplementInterfaceA';
  const type THackType = \ImplementInterfaceA;
  const keyset<string> FIELD_NAMES = keyset[
  ];
  const keyset<classname<Types\InterfaceType>> INTERFACES = keyset[
    IIntrospectionInterfaceA::class,
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
