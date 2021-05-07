/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run
 * /home/jjergus/work/code/hack-graphql/vendor/hhvm/hacktest/bin/hacktest
 *
 *
 * @generated SignedSource<<6e643145b86cdea84ab0f737331c75dc>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL\Types;
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
    dict<string, \Graphpinator\Parser\Value\ArgumentValue> $args,
    \Slack\GraphQL\__Private\Variables $vars,
  ): Awaitable<mixed> {
    switch ($field_name) {
      case 'viewer':
        return await \UserQueryAttributes::getViewer();
      case 'user':
        return await \UserQueryAttributes::getUser(Types\IntInputType::nonNullable()->coerceNode($args['id']->getValue(), $vars));
      case 'nested_list_sum':
        return \UserQueryAttributes::getNestedListSum(Types\IntInputType::nonNullable()->nonNullableListOf()->nonNullableListOf()->coerceNode($args['numbers']->getValue(), $vars));
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
      case 'nested_list_sum':
        return \Slack\GraphQL\Types\IntOutputType::nullable();
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
    dict<string, \Graphpinator\Parser\Value\ArgumentValue> $_args,
    \Slack\GraphQL\__Private\Variables $_vars,
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
    dict<string, \Graphpinator\Parser\Value\ArgumentValue> $_args,
    \Slack\GraphQL\__Private\Variables $_vars,
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
