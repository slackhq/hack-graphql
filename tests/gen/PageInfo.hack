/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<e498c61f1f44204378eadf32d810a0cd>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class PageInfo extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'PageInfo';
  const type THackType = \Slack\GraphQL\Pagination\PageInfo;
  const keyset<string> FIELD_NAMES = keyset[
    'startCursor',
    'endCursor',
    'hasPreviousPage',
    'hasNextPage',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'startCursor':
        return new GraphQL\FieldDefinition(
          'startCursor',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['startCursor'] ?? null,
          null,
          false,
          null,
        );
      case 'endCursor':
        return new GraphQL\FieldDefinition(
          'endCursor',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['endCursor'] ?? null,
          null,
          false,
          null,
        );
      case 'hasPreviousPage':
        return new GraphQL\FieldDefinition(
          'hasPreviousPage',
          Types\BooleanType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['hasPreviousPage'] ?? null,
          null,
          false,
          null,
        );
      case 'hasNextPage':
        return new GraphQL\FieldDefinition(
          'hasNextPage',
          Types\BooleanType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['hasNextPage'] ?? null,
          null,
          false,
          null,
        );
      default:
        return null;
    }
  }
}
