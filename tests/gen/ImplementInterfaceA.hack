/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<be28ebe77d2668d5f56bc1496429b5bd>>
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
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
    'IIntrospectionInterfaceA' => IIntrospectionInterfaceA::class,
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
