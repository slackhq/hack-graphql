/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<d5eadc450c9f50d9237a9a320098416a>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class AnotherObjectShape extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'AnotherObjectShape';
  const type THackType = \AnotherObjectShape;

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'abc':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nonNullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> $parent['abc'],
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

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

final class Concrete extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Concrete';
  const type THackType = \Concrete;

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

final class CreateTeamInput extends \Slack\GraphQL\Types\InputObjectType {

  const NAME = 'CreateTeamInput';
  const type TCoerced = \TCreateTeamInput;
  const keyset<string> FIELD_NAMES = keyset [
    'name',
  ];

  <<__Override>>
  public function coerceFieldValues(
    KeyedContainer<arraykey, mixed> $fields,
  ): this::TCoerced {
    $ret = shape();
    $ret['name'] = Types\StringInputType::nonNullable()->coerceNamedValue('name', $fields);
    return $ret;
  }

  <<__Override>>
  public function coerceFieldNodes(
    dict<string, \Graphpinator\Parser\Value\Value> $fields,
    dict<string, mixed> $vars,
  ): this::TCoerced {
    $ret = shape();
    $ret['name'] = Types\StringInputType::nonNullable()->coerceNamedNode('name', $fields, $vars);
    return $ret;
  }
}

final class CreateUserInput extends \Slack\GraphQL\Types\InputObjectType {

  const NAME = 'CreateUserInput';
  const type TCoerced = \TCreateUserInput;
  const keyset<string> FIELD_NAMES = keyset [
    'name',
    'is_active',
    'team',
    'favorite_color',
  ];

  <<__Override>>
  public function coerceFieldValues(
    KeyedContainer<arraykey, mixed> $fields,
  ): this::TCoerced {
    $ret = shape();
    $ret['name'] = Types\StringInputType::nonNullable()->coerceNamedValue('name', $fields);
    if (C\contains_key($fields, 'is_active')) {
      $ret['is_active'] = Types\BooleanInputType::nullable()->coerceNamedValue('is_active', $fields);
    }
    if (C\contains_key($fields, 'team')) {
      $ret['team'] = CreateTeamInput::nullable()->coerceNamedValue('team', $fields);
    }
    if (C\contains_key($fields, 'favorite_color')) {
      $ret['favorite_color'] = FavoriteColorInputType::nullable()->coerceNamedValue('favorite_color', $fields);
    }
    return $ret;
  }

  <<__Override>>
  public function coerceFieldNodes(
    dict<string, \Graphpinator\Parser\Value\Value> $fields,
    dict<string, mixed> $vars,
  ): this::TCoerced {
    $ret = shape();
    $ret['name'] = Types\StringInputType::nonNullable()->coerceNamedNode('name', $fields, $vars);
    if ($this->hasValue('is_active', $fields, $vars)) {
      $ret['is_active'] = Types\BooleanInputType::nullable()->coerceNamedNode('is_active', $fields, $vars);
    }
    if ($this->hasValue('team', $fields, $vars)) {
      $ret['team'] = CreateTeamInput::nullable()->coerceNamedNode('team', $fields, $vars);
    }
    if ($this->hasValue('favorite_color', $fields, $vars)) {
      $ret['favorite_color'] = FavoriteColorInputType::nullable()->coerceNamedNode('favorite_color', $fields, $vars);
    }
    return $ret;
  }
}

final class ErrorTest extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'ErrorTest';
  const type THackType = \ErrorTestObj;

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

final class Human extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Human';
  const type THackType = \Human;

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

final class InterfaceA extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'InterfaceA';
  const type THackType = \InterfaceA;

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

  const NAME = 'InterfaceB';
  const type THackType = \InterfaceB;

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

final class Mutation extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Mutation';
  const type THackType = \Slack\GraphQL\Root;

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

final class ObjectShape extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'ObjectShape';
  const type THackType = \ObjectShape;

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'foo':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent['foo'],
        );
      case 'bar':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent['bar'] ?? null,
        );
      case 'baz':
        return new GraphQL\FieldDefinition(
          AnotherObjectShape::nullable(),
          async ($parent, $args, $vars) ==> $parent['baz'],
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class OutputTypeTest extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'OutputTypeTest';
  const type THackType = \OutputTypeTestObj;

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

final class Query extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Query';
  const type THackType = \Slack\GraphQL\Root;

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
      case 'getObjectShape':
        return new GraphQL\FieldDefinition(
          ObjectShape::nullable(),
          async ($parent, $args, $vars) ==> \ObjectTypeTestEntrypoint::getObjectShape(),
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
      case 'optional_field_test':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> \UserQueryAttributes::optionalFieldTest(
            CreateUserInput::nonNullable()->coerceNode($args['input']->getValue(), $vars),
          ),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class Team extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Team';
  const type THackType = \Team;

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

final class User extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'User';
  const type THackType = \User;

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

abstract final class Schema extends \Slack\GraphQL\BaseSchema {

  const dict<string, classname<Types\NamedInputType>> INPUT_TYPES = dict[
    'Boolean' => Types\BooleanInputType::class,
    'CreateTeamInput' => CreateTeamInput::class,
    'CreateUserInput' => CreateUserInput::class,
    'FavoriteColor' => FavoriteColorInputType::class,
    'Int' => Types\IntInputType::class,
    'String' => Types\StringInputType::class,
  ];
  const dict<string, classname<Types\NamedOutputType>> OUTPUT_TYPES = dict[
    'AnotherObjectShape' => AnotherObjectShape::class,
    'Boolean' => Types\BooleanOutputType::class,
    'Bot' => Bot::class,
    'Concrete' => Concrete::class,
    'ErrorTest' => ErrorTest::class,
    'FavoriteColor' => FavoriteColorOutputType::class,
    'Human' => Human::class,
    'Int' => Types\IntOutputType::class,
    'InterfaceA' => InterfaceA::class,
    'InterfaceB' => InterfaceB::class,
    'Mutation' => Mutation::class,
    'ObjectShape' => ObjectShape::class,
    'OutputTypeTest' => OutputTypeTest::class,
    'Query' => Query::class,
    'String' => Types\StringOutputType::class,
    'Team' => Team::class,
    'User' => User::class,
  ];
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
