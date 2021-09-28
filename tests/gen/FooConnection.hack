/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<48c4764c438d48a28882faeec41c7594>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class FooConnection extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'FooConnection';
  const type THackType = \Foo\FooConnection;
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
          FooObjectEdge::nonNullable()->nullableOutputListOf(),
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
