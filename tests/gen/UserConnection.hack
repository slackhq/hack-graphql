/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<d55e70464a663af88a507dc7b5eabcc5>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class UserConnection extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'UserConnection';
  const type THackType = \UserConnection;
  const keyset<string> FIELD_NAMES = keyset[
    'edges',
    'pageInfo',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'edges':
        return new GraphQL\FieldDefinition(
          'edges',
          UserEdge::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->getEdges(),
          vec[],
        );
      case 'pageInfo':
        return new GraphQL\FieldDefinition(
          'pageInfo',
          PageInfo::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->getPageInfo(),
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
