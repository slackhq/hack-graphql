/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<78baf0213f0d9e14e803297f781e40f4>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Role extends \Slack\GraphQL\Types\EnumType {

  const NAME = 'Role';
  const type THackType = \Role;
  const \HH\enumname<this::THackType> HACK_ENUM = \Role::class;
  const vec<GraphQL\Introspection\__EnumValue> ENUM_VALUES = vec[
    shape(
      'name' => 'ADMIN',
      'isDeprecated' => false,
    ),
    shape(
      'name' => 'STAFF',
      'isDeprecated' => false,
    ),
  ];
}
