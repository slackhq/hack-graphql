/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<c433c1cc0fb72874364dc2473249cc5d>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class IntrospectionEnum extends \Slack\GraphQL\Types\EnumType {

  const NAME = 'IntrospectionEnum';
  const type THackType = \IntrospectionEnum;
  const \HH\enumname<this::THackType> HACK_ENUM = \IntrospectionEnum::class;
  const vec<GraphQL\Introspection\__EnumValue> ENUM_VALUES = vec[
    shape(
      'name' => 'A',
      'isDeprecated' => false,
    ),
    shape(
      'name' => 'B',
      'isDeprecated' => false,
    ),
  ];
}
