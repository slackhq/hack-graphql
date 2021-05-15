/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<2cf0ff528404fabaeab51436705748c6>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class User extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'User';
  const type THackType = \User;
  const keyset<string> FIELD_NAMES = keyset[
    'id',
    'is_active',
    'name',
    'team',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'id':
        return new GraphQL\FieldDefinition(
          'id',
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getId(),
        );
      case 'is_active':
        return new GraphQL\FieldDefinition(
          'is_active',
          Types\BooleanOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->isActive(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'team':
        return new GraphQL\FieldDefinition(
          'team',
          Team::nullable(),
          async ($parent, $args, $vars) ==> await $parent->getTeam(),
        );
      default:
        return null;
    }
  }
}
