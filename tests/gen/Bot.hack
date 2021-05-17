/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<96a0d6f0089ed1ab88e5b3d028558ea4>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Bot extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Bot';
  const type THackType = \Bot;

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'id':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getId(),
        );
      case 'is_active':
        return new GraphQL\FieldDefinition(
          Types\BooleanOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->isActive(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'primary_function':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getPrimaryFunction(),
        );
      case 'team':
        return new GraphQL\FieldDefinition(
          Team::nullable(),
          async ($parent, $args, $vars) ==> await $parent->getTeam(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}
