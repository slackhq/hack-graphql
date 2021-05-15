/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<c9b03f83259b4600fd7882512908bc09>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Team extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Team';
  const type THackType = \Team;
  const keyset<string> FIELD_NAMES = keyset[
    'description',
    'id',
    'name',
    'num_users',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getDescription(
            Types\BooleanInputType::nonNullable()->coerceNamedNode('short', $args, $vars),
          ),
        );
      case 'id':
        return new GraphQL\FieldDefinition(
          'id',
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getId(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'num_users':
        return new GraphQL\FieldDefinition(
          'num_users',
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> await $parent->getNumUsers(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}
