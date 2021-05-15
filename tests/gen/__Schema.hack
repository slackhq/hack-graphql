/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<90a0cf360d5c5c05287cfeeab4b7d88a>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __Schema extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__Schema';
  const type THackType = \Slack\GraphQL\Introspection\__Schema;
  const keyset<string> FIELD_NAMES = keyset[
    'queryType',
    'mutationType',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'queryType':
        return new GraphQL\FieldDefinition(
          'queryType',
          __Type::nullable(),
          async ($parent, $args, $vars) ==> $parent->getQueryType(),
        );
      case 'mutationType':
        return new GraphQL\FieldDefinition(
          'mutationType',
          __Type::nullable(),
          async ($parent, $args, $vars) ==> $parent->getMutationType(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}
