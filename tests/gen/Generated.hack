/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<2fd9942046ca85bed913f4a4733c55dc>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\Dict;
use namespace Facebook\TypeAssert;
use namespace Facebook\TypeCoerce;

abstract final class Schema extends \Slack\GraphQL\BaseSchema {

  const bool SUPPORTS_MUTATIONS = true;

  public static async function resolveQuery(
    \Graphpinator\Parser\Operation\Operation $operation,
    \Slack\GraphQL\Variables $variables,
  ): Awaitable<GraphQL\ValidFieldResult<?dict<string, mixed>>> {
    return await Query::nullable()->resolveAsync(new GraphQL\Root(), $operation, $variables);
  }

  public static async function resolveMutation(
    \Graphpinator\Parser\Operation\Operation $operation,
    \Slack\GraphQL\Variables $variables,
  ): Awaitable<GraphQL\ValidFieldResult<?dict<string, mixed>>> {
    return await Mutation::nullable()->resolveAsync(new GraphQL\Root(), $operation, $variables);
  }
}

final class Query extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = GraphQL\Root;
  const NAME = 'Query';

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'error_test':
        return new GraphQL\FieldDefinition(
          ErrorTest::nullable(),
          async ($parent, $args, $vars) ==> \ErrorTestObj::get(),
        );
      case 'error_test_nn':
        return new GraphQL\FieldDefinition(
          ErrorTest::nonNullable(),
          async ($parent, $args, $vars) ==> \ErrorTestObj::getNonNullable(),
        );
      case 'getConcrete':
        return new GraphQL\FieldDefinition(
          Concrete::nullable(),
          async ($parent, $args, $vars) ==> \Concrete::getConcrete(),
        );
      case 'getInterfaceA':
        return new GraphQL\FieldDefinition(
          InterfaceA::nullable(),
          async ($parent, $args, $vars) ==> \Concrete::getInterfaceA(),
        );
      case 'getInterfaceB':
        return new GraphQL\FieldDefinition(
          InterfaceB::nullable(),
          async ($parent, $args, $vars) ==> \Concrete::getInterfaceB(),
        );
      case 'output_type_test':
        return new GraphQL\FieldDefinition(
          OutputTypeTest::nullable(),
          async ($parent, $args, $vars) ==> \OutputTypeTestObj::get(),
        );
      case 'viewer':
        return new GraphQL\FieldDefinition(
          User::nullable(),
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getViewer(),
        );
      case 'user':
        return new GraphQL\FieldDefinition(
          User::nullable(),
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getUser(
            Types\IntInputType::nonNullable()->coerceNode($args['id']->getValue(), $vars),
          ),
        );
      case 'human':
        return new GraphQL\FieldDefinition(
          Human::nullable(),
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getHuman(
            Types\IntInputType::nonNullable()->coerceNode($args['id']->getValue(), $vars),
          ),
        );
      case 'bot':
        return new GraphQL\FieldDefinition(
          Bot::nullable(),
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getBot(
            Types\IntInputType::nonNullable()->coerceNode($args['id']->getValue(), $vars),
          ),
        );
      case 'nested_list_sum':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> \UserQueryAttributes::getNestedListSum(
            Types\IntInputType::nonNullable()->nonNullableListOf()->nonNullableListOf()->coerceNode($args['numbers']->getValue(), $vars),
          ),
        );
      case 'takes_favorite_color':
        return new GraphQL\FieldDefinition(
          Types\BooleanOutputType::nullable(),
          async ($parent, $args, $vars) ==> \UserQueryAttributes::takesFavoriteColor(
            FavoriteColorInputType::nonNullable()->coerceNode($args['favorite_color']->getValue(), $vars),
          ),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class Mutation extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = GraphQL\Root;
  const NAME = 'Mutation';

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'pokeUser':
        return new GraphQL\FieldDefinition(
          User::nullable(),
          async ($parent, $args, $vars) ==> await \UserMutationAttributes::pokeUser(
            Types\IntInputType::nonNullable()->coerceNode($args['id']->getValue(), $vars),
          ),
        );
      case 'createUser':
        return new GraphQL\FieldDefinition(
          User::nullable(),
          async ($parent, $args, $vars) ==> await \UserMutationAttributes::createUser(
            CreateUserInput::nonNullable()->coerceNode($args['input']->getValue(), $vars),
          ),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class InterfaceA extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \InterfaceA;
  const NAME = 'InterfaceA';

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'foo':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->foo(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class InterfaceB extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \InterfaceB;
  const NAME = 'InterfaceB';

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'foo':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->foo(),
        );
      case 'bar':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->bar(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class User extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \User;
  const NAME = 'User';

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'id':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getId(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'team':
        return new GraphQL\FieldDefinition(
          Team::nullable(),
          async ($parent, $args, $vars) ==> await $parent->getTeam(),
        );
      case 'is_active':
        return new GraphQL\FieldDefinition(
          Types\BooleanOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->isActive(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class ErrorTest extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \ErrorTestObj;
  const NAME = 'ErrorTest';

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'no_error':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->no_error(),
        );
      case 'user_facing_error':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->user_facing_error(),
        );
      case 'hidden_exception':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->hidden_exception(),
        );
      case 'non_nullable':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nonNullable(),
          async ($parent, $args, $vars) ==> $parent->non_nullable(),
        );
      case 'nested':
        return new GraphQL\FieldDefinition(
          ErrorTest::nullable(),
          async ($parent, $args, $vars) ==> $parent->nested(),
        );
      case 'nested_nn':
        return new GraphQL\FieldDefinition(
          ErrorTest::nonNullable(),
          async ($parent, $args, $vars) ==> $parent->nested_nn(),
        );
      case 'bad_int_list_n_of_n':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> $parent->bad_int_list_n_of_n(),
        );
      case 'bad_int_list_n_of_nn':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nonNullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> $parent->bad_int_list_n_of_nn(),
        );
      case 'bad_int_list_nn_of_nn':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nonNullable()->nonNullableListOf(),
          async ($parent, $args, $vars) ==> $parent->bad_int_list_nn_of_nn(),
        );
      case 'nested_list_n_of_n':
        return new GraphQL\FieldDefinition(
          ErrorTest::nullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> $parent->nested_list_n_of_n(),
        );
      case 'nested_list_n_of_nn':
        return new GraphQL\FieldDefinition(
          ErrorTest::nonNullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> $parent->nested_list_n_of_nn(),
        );
      case 'nested_list_nn_of_nn':
        return new GraphQL\FieldDefinition(
          ErrorTest::nonNullable()->nonNullableListOf(),
          async ($parent, $args, $vars) ==> $parent->nested_list_nn_of_nn(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class Concrete extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \Concrete;
  const NAME = 'Concrete';

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'foo':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->foo(),
        );
      case 'bar':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->bar(),
        );
      case 'baz':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->baz(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class OutputTypeTest extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \OutputTypeTestObj;
  const NAME = 'OutputTypeTest';

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'scalar':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->scalar(),
        );
      case 'nullable':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->nullable(),
        );
      case 'awaitable':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> await $parent->awaitable(),
        );
      case 'awaitable_nullable':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> await $parent->awaitable_nullable(),
        );
      case 'list':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nonNullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> $parent->list(),
        );
      case 'awaitable_nullable_list':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nonNullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> await $parent->awaitable_nullable_list(),
        );
      case 'nested_lists':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nullable()->nonNullableListOf()->nullableListOf()->nullableListOf(),
          async ($parent, $args, $vars) ==> $parent->nested_lists(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class Human extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \Human;
  const NAME = 'Human';

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'id':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getId(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'team':
        return new GraphQL\FieldDefinition(
          Team::nullable(),
          async ($parent, $args, $vars) ==> await $parent->getTeam(),
        );
      case 'is_active':
        return new GraphQL\FieldDefinition(
          Types\BooleanOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->isActive(),
        );
      case 'favorite_color':
        return new GraphQL\FieldDefinition(
          FavoriteColorOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getFavoriteColor(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class Bot extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \Bot;
  const NAME = 'Bot';

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'id':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getId(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'team':
        return new GraphQL\FieldDefinition(
          Team::nullable(),
          async ($parent, $args, $vars) ==> await $parent->getTeam(),
        );
      case 'is_active':
        return new GraphQL\FieldDefinition(
          Types\BooleanOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->isActive(),
        );
      case 'primary_function':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getPrimaryFunction(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class Team extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \Team;
  const NAME = 'Team';

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'id':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getId(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'num_users':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> await $parent->getNumUsers(),
        );
      case 'description':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getDescription(
            Types\BooleanInputType::nonNullable()->coerceNode($args['short']->getValue(), $vars),
          ),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class FavoriteColorInputType extends \Slack\GraphQL\Types\EnumInputType {

  const NAME = 'FavoriteColor';
  const type TCoerced = \FavoriteColor;
  const \HH\enumname<this::TCoerced> HACK_ENUM = \FavoriteColor::class;
}

final class FavoriteColorOutputType
  extends \Slack\GraphQL\Types\EnumOutputType {

  const NAME = 'FavoriteColor';
  const type THackType = \FavoriteColor;
  const \HH\enumname<this::THackType> HACK_ENUM = \FavoriteColor::class;
}

final class CreateTeamInput extends \Slack\GraphQL\Types\InputObjectType {

  const type TCoerced = \TCreateTeamInput;
  const NAME = 'CreateTeamInput';
  const keyset<string> FIELD_NAMES = keyset [
    'name',
  ];

  <<__Override>>
  public function coerceFieldValues(
    KeyedContainer<arraykey, mixed> $args,
  ): this::TCoerced {
    return shape(
      'name' => Types\StringInputType::nonNullable()->coerceValue($args['name']),
    );
  }

  <<__Override>>
  public function coerceFieldNodes(
    KeyedContainer<string, \Graphpinator\Parser\Value\Value> $args,
    dict<string, mixed> $vars,
  ): this::TCoerced {
    return shape(
      'name' => Types\StringInputType::nonNullable()->coerceNode($args['name'], $vars),
    );
  }
}

final class CreateUserInput extends \Slack\GraphQL\Types\InputObjectType {

  const type TCoerced = \TCreateUserInput;
  const NAME = 'CreateUserInput';
  const keyset<string> FIELD_NAMES = keyset [
    'name',
    'is_active',
    'team',
    'favorite_color',
  ];

  <<__Override>>
  public function coerceFieldValues(
    KeyedContainer<arraykey, mixed> $args,
  ): this::TCoerced {
    return shape(
      'name' => Types\StringInputType::nonNullable()->coerceValue($args['name']),
      'is_active' => Types\BooleanInputType::nonNullable()->coerceValue($args['is_active']),
      'team' => CreateTeamInput::nonNullable()->coerceValue($args['team']),
      'favorite_color' => FavoriteColorInputType::nonNullable()->coerceValue($args['favorite_color']),
    );
  }

  <<__Override>>
  public function coerceFieldNodes(
    KeyedContainer<string, \Graphpinator\Parser\Value\Value> $args,
    dict<string, mixed> $vars,
  ): this::TCoerced {
    return shape(
      'name' => Types\StringInputType::nonNullable()->coerceNode($args['name'], $vars),
      'is_active' => Types\BooleanInputType::nonNullable()->coerceNode($args['is_active'], $vars),
      'team' => CreateTeamInput::nonNullable()->coerceNode($args['team'], $vars),
      'favorite_color' => FavoriteColorInputType::nonNullable()->coerceNode($args['favorite_color'], $vars),
    );
  }
}
