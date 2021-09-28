/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<d403220d5e6cfa75995ec7f641e05f68>>
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

  public function getDirectives(): vec<GraphQL\ObjectDirective> {
    return vec[];
  }
}
