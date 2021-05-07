/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run
 * /home/jjergus/work/code/hack-graphql/vendor/hhvm/hacktest/bin/hacktest
 *
 *
 * @generated SignedSource<<6038758170ed55545b1df61d19a1dbf9>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace HH\Lib\Dict;

abstract final class Schema extends \Slack\GraphQL\BaseSchema {

  public static async function resolveQuery(
    \Graphpinator\Parser\Operation\Operation $operation,
    \Slack\GraphQL\__Private\Variables $variables,
  ): Awaitable<mixed> {
    $query = Query::nullable();

    $data = dict[];
    foreach ($operation->getFields()->getFields() as $field) {
      $data[$field->getName()] = self::resolveField($field, $query, null, $variables);
    }

    return await Dict\from_async($data);
  }
}

final class Query extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = null;
  const NAME = 'Query';

  public static async function resolveField(
    string $field_name,
    self::THackType $_,
    vec<\Slack\GraphQL\__Private\Argument> $args,
  ): Awaitable<mixed> {
    switch ($field_name) {
      case 'viewer':
        return await \UserQueryAttributes::getViewer();
      case 'user':
        return await \UserQueryAttributes::getUser($args[0]->asInt());
      default:
        throw new \Error('Unknown field: '.$field_name);
    }
  }

  public static function resolveType(
    string $field_name,
  ): \Slack\GraphQL\Types\BaseType {
    switch ($field_name) {
      case 'viewer':
        return User::nullable();
      case 'user':
        return User::nullable();
      default:
        throw new \Error('Unknown field: '.$field_name);
    }
  }
}

final class User extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \User;
  const NAME = 'User';

  public static async function resolveField(
    string $field_name,
    self::THackType $resolved_parent,
    vec<\Slack\GraphQL\__Private\Argument> $_args,
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
        return \Slack\GraphQL\Types\IntOutputType::nullable();
      case 'name':
        return \Slack\GraphQL\Types\StringOutputType::nullable();
      case 'team':
        return Team::nullable();
      default:
        throw new \Error('Unknown field: '.$field_name);
    }
  }
}

final class Team extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \Team;
  const NAME = 'Team';

  public static async function resolveField(
    string $field_name,
    self::THackType $resolved_parent,
    vec<\Slack\GraphQL\__Private\Argument> $_args,
  ): Awaitable<mixed> {
    switch ($field_name) {
      case 'id':
        return $resolved_parent->getId();
      case 'name':
        return $resolved_parent->getName();
      case 'num_users':
        return await $resolved_parent->getNumUsers();
      default:
        throw new \Error('Unknown field: '.$field_name);
    }
  }

  public static function resolveType(
    string $field_name,
  ): \Slack\GraphQL\Types\BaseType {
    switch ($field_name) {
      case 'id':
        return \Slack\GraphQL\Types\IntOutputType::nullable();
      case 'name':
        return \Slack\GraphQL\Types\StringOutputType::nullable();
      case 'num_users':
        return \Slack\GraphQL\Types\IntOutputType::nullable();
      default:
        throw new \Error('Unknown field: '.$field_name);
    }
  }
}
