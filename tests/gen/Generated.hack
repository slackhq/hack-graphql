/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run /app/vendor/hhvm/hacktest/bin/hacktest
 *
 *
 * @generated SignedSource<<cb129122d26fb4c63d2d690e01970cc9>>
 */
namespace Slack\GraphQL\Test\Generated;

class User extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \User;

  public static async function resolveField(
    string $field_name,
    self::THackType $resolved_parent,
  ): Awaitable<mixed> {
    switch ($field_name) {
      case 'id':
        return $resolved_parent->getId();
      case 'name':
        return $resolved_parent->getName();
      case 'team':
        return await $resolved_parent->getTeam();
      default:
        throw new \Error('Unknown field: '.$field_name);
    }
  }

  public static function resolveType(
    string $field_name,
  ): \Slack\GraphQL\Types\BaseType {
    switch ($field_name) {
      case 'id':
        return new \Slack\GraphQL\Types\IntType();
      case 'name':
        return new \Slack\GraphQL\Types\StringType();
      case 'team':
        return new Team();
      default:
        throw new \Error('Unknown field: '.$field_name);
    }
  }
}

class Team extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \Team;

  public static async function resolveField(
    string $field_name,
    self::THackType $resolved_parent,
  ): Awaitable<mixed> {
    switch ($field_name) {
      case 'id':
        return $resolved_parent->getId();
      case 'name':
        return $resolved_parent->getName();
      default:
        throw new \Error('Unknown field: '.$field_name);
    }
  }

  public static function resolveType(
    string $field_name,
  ): \Slack\GraphQL\Types\BaseType {
    switch ($field_name) {
      case 'id':
        return new \Slack\GraphQL\Types\IntType();
      case 'name':
        return new \Slack\GraphQL\Types\StringType();
      default:
        throw new \Error('Unknown field: '.$field_name);
    }
  }
}
