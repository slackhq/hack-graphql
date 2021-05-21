/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<c869d010cabe358e6e0bdd6a37b68868>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Bot extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Bot';
  const type THackType = \Bot;
  const keyset<string> FIELD_NAMES = keyset[
    'id',
    'is_active',
    'name',
    'primary_function',
    'team',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'id':
        return new GraphQL\FieldDefinition(
          'id',
          Types\IntType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getId(),
        );
      case 'is_active':
        return new GraphQL\FieldDefinition(
          'is_active',
          Types\BooleanType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->isActive(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'primary_function':
        return new GraphQL\FieldDefinition(
          'primary_function',
          Types\StringType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getPrimaryFunction(),
        );
      case 'team':
        return new GraphQL\FieldDefinition(
          'team',
          Team::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->getTeam(),
        );
      default:
        return null;
    }
  }
}
