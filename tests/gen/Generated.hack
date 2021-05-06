/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run /app/vendor/hhvm/hacktest/bin/hacktest
 *
 *
 * @generated SignedSource<<d1d7af1711847a5e3a63b8d2938a1e62>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace HH\Lib\Dict;

abstract final class Schema extends \Slack\GraphQL\BaseSchema {

  public static async function resolveQuery(
    \Graphpinator\Parser\Operation\Operation $operation,
  ): Awaitable<mixed> {
    $query = new Query();

    $data = dict[];
    foreach ($operation->getFields() as $field) {
      $data[$field->getName()] = self::resolveField($field, $query, null);
    }

    return await Dict\from_async($data);
  }
}

final class Query extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = null;

  public static async function resolveField(
    string $field_name,
    self::THackType $_,
  ): Awaitable<mixed> {
    switch ($field_name) {
      case 'viewer':
        return await \UserQueryAttributes::getViewer();
      default:
        throw new \Error('Unknown field: '.$field_name);
    }
  }

  public static function resolveType(
    string $field_name,
  ): \Slack\GraphQL\Types\BaseType {
    switch ($field_name) {
      case 'viewer':
        return new User();
      default:
        throw new \Error('Unknown field: '.$field_name);
    }
  }
}

final class User extends \Slack\GraphQL\Types\ObjectType {

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

final class Team extends \Slack\GraphQL\Types\ObjectType {

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
