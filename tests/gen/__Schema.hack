/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<876a81f9486af962c51aff04ae579805>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __Schema extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__Schema';
  const type THackType = \Slack\GraphQL\Introspection\__Schema;
  const keyset<string> FIELD_NAMES = keyset[
    'mutationType',
    'queryType',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'mutationType':
        return new GraphQL\FieldDefinition(
          'mutationType',
          __Type::nullable(),
          async ($parent, $args, $vars) ==> $parent->getMutationType(),
        );
      case 'queryType':
        return new GraphQL\FieldDefinition(
          'queryType',
          __Type::nullable(),
          async ($parent, $args, $vars) ==> $parent->getQueryType(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}
