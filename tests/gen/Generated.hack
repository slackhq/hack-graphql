/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<f696b645efb4fa8549f3717ffcab718b>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Query extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = GraphQL\Root;
  const NAME = 'Query';
  const keyset<string> FIELD_NAMES = keyset[
    'error_test',
    'error_test_nn',
    'getConcrete',
    'getInterfaceA',
    'getInterfaceB',
    'getObjectShape',
    'output_type_test',
    'viewer',
    'user',
    'human',
    'bot',
    'nested_list_sum',
    'takes_favorite_color',
    'optional_field_test',
    '__schema',
    '__type',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'error_test':
        return new GraphQL\FieldDefinition(
          'error_test',
          ErrorTest::nullable(),
          async ($schema, $parent, $args, $vars) ==> \ErrorTestObj::get(),
        );
      case 'error_test_nn':
        return new GraphQL\FieldDefinition(
          'error_test_nn',
          ErrorTest::nonNullable(),
          async ($schema, $parent, $args, $vars) ==> \ErrorTestObj::getNonNullable(),
        );
      case 'getConcrete':
        return new GraphQL\FieldDefinition(
          'getConcrete',
          Concrete::nullable(),
          async ($schema, $parent, $args, $vars) ==> \Concrete::getConcrete(),
        );
      case 'getInterfaceA':
        return new GraphQL\FieldDefinition(
          'getInterfaceA',
          InterfaceA::nullable(),
          async ($schema, $parent, $args, $vars) ==> \Concrete::getInterfaceA(),
        );
      case 'getInterfaceB':
        return new GraphQL\FieldDefinition(
          'getInterfaceB',
          InterfaceB::nullable(),
          async ($schema, $parent, $args, $vars) ==> \Concrete::getInterfaceB(),
        );
      case 'getObjectShape':
        return new GraphQL\FieldDefinition(
          'getObjectShape',
          ObjectShape::nullable(),
          async ($schema, $parent, $args, $vars) ==> \ObjectTypeTestEntrypoint::getObjectShape(),
        );
      case 'output_type_test':
        return new GraphQL\FieldDefinition(
          'output_type_test',
          OutputTypeTest::nullable(),
          async ($schema, $parent, $args, $vars) ==> \OutputTypeTestObj::get(),
        );
      case 'viewer':
        return new GraphQL\FieldDefinition(
          'viewer',
          User::nullable(),
          async ($schema, $parent, $args, $vars) ==> await \UserQueryAttributes::getViewer(),
        );
      case 'user':
        return new GraphQL\FieldDefinition(
          'user',
          User::nullable(),
          async ($schema, $parent, $args, $vars) ==> await \UserQueryAttributes::getUser(
            Types\IntInputType::nonNullable()->coerceNode($args['id']->getValue(), $vars),
          ),
        );
      case 'human':
        return new GraphQL\FieldDefinition(
          'human',
          Human::nullable(),
          async ($schema, $parent, $args, $vars) ==> await \UserQueryAttributes::getHuman(
            Types\IntInputType::nonNullable()->coerceNode($args['id']->getValue(), $vars),
          ),
        );
      case 'bot':
        return new GraphQL\FieldDefinition(
          'bot',
          Bot::nullable(),
          async ($schema, $parent, $args, $vars) ==> await \UserQueryAttributes::getBot(
            Types\IntInputType::nonNullable()->coerceNode($args['id']->getValue(), $vars),
          ),
        );
      case 'nested_list_sum':
        return new GraphQL\FieldDefinition(
          'nested_list_sum',
          Types\IntOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> \UserQueryAttributes::getNestedListSum(
            Types\IntInputType::nonNullable()->nonNullableListOf()->nonNullableListOf()->coerceNode($args['numbers']->getValue(), $vars),
          ),
        );
      case 'takes_favorite_color':
        return new GraphQL\FieldDefinition(
          'takes_favorite_color',
          Types\BooleanOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> \UserQueryAttributes::takesFavoriteColor(
            FavoriteColorInputType::nonNullable()->coerceNode($args['favorite_color']->getValue(), $vars),
          ),
        );
      case 'optional_field_test':
        return new GraphQL\FieldDefinition(
          'optional_field_test',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> \UserQueryAttributes::optionalFieldTest(
            CreateUserInput::nonNullable()->coerceNode($args['input']->getValue(), $vars),
          ),
        );
      case '__schema':
        return new GraphQL\FieldDefinition(
          '__schema',
          __Schema::nullable(),
          async ($schema, $parent, $args, $vars) ==> \Slack\GraphQL\Introspection\IntrospectionQueryFields::getSchema(),
        );
      case '__type':
        return new GraphQL\FieldDefinition(
          '__type',
          __Type::nullable(),
          async ($schema, $parent, $args, $vars) ==> \Slack\GraphQL\Introspection\IntrospectionQueryFields::getType(
            Types\StringInputType::nonNullable()->coerceNode($args['name']->getValue(), $vars),
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
  const keyset<string> FIELD_NAMES = keyset[
    'pokeUser',
    'createUser',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'pokeUser':
        return new GraphQL\FieldDefinition(
          'pokeUser',
          User::nullable(),
          async ($schema, $parent, $args, $vars) ==> await \UserMutationAttributes::pokeUser(
            Types\IntInputType::nonNullable()->coerceNode($args['id']->getValue(), $vars),
          ),
        );
      case 'createUser':
        return new GraphQL\FieldDefinition(
          'createUser',
          User::nullable(),
          async ($schema, $parent, $args, $vars) ==> await \UserMutationAttributes::createUser(
            CreateUserInput::nonNullable()->coerceNode($args['input']->getValue(), $vars),
          ),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class ObjectShape extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \ObjectShape;
  const NAME = 'ObjectShape';
  const keyset<string> FIELD_NAMES = keyset[
    'foo',
    'bar',
    'baz',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'foo':
        return new GraphQL\FieldDefinition(
          'foo',
          Types\IntOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent['foo'],
        );
      case 'bar':
        return new GraphQL\FieldDefinition(
          'bar',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent['bar'] ?? null,
        );
      case 'baz':
        return new GraphQL\FieldDefinition(
          'baz',
          AnotherObjectShape::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent['baz'],
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class AnotherObjectShape extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \AnotherObjectShape;
  const NAME = 'AnotherObjectShape';
  const keyset<string> FIELD_NAMES = keyset[
    'abc',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'abc':
        return new GraphQL\FieldDefinition(
          'abc',
          Types\IntOutputType::nonNullable()->nullableListOf(),
          async ($schema, $parent, $args, $vars) ==> $parent['abc'],
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class InterfaceA extends \Slack\GraphQL\Types\InterfaceType {

  const type THackType = \InterfaceA;
  const NAME = 'InterfaceA';
  const keyset<string> FIELD_NAMES = keyset[
    'foo',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'foo':
        return new GraphQL\FieldDefinition(
          'foo',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->foo(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class InterfaceB extends \Slack\GraphQL\Types\InterfaceType {

  const type THackType = \InterfaceB;
  const NAME = 'InterfaceB';
  const keyset<string> FIELD_NAMES = keyset[
    'foo',
    'bar',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'foo':
        return new GraphQL\FieldDefinition(
          'foo',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->foo(),
        );
      case 'bar':
        return new GraphQL\FieldDefinition(
          'bar',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->bar(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class User extends \Slack\GraphQL\Types\InterfaceType {

  const type THackType = \User;
  const NAME = 'User';
  const keyset<string> FIELD_NAMES = keyset[
    'id',
    'name',
    'team',
    'is_active',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'id':
        return new GraphQL\FieldDefinition(
          'id',
          Types\IntOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getId(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getName(),
        );
      case 'team':
        return new GraphQL\FieldDefinition(
          'team',
          Team::nullable(),
          async ($schema, $parent, $args, $vars) ==> await $parent->getTeam(),
        );
      case 'is_active':
        return new GraphQL\FieldDefinition(
          'is_active',
          Types\BooleanOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->isActive(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class ErrorTest extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \ErrorTestObj;
  const NAME = 'ErrorTest';
  const keyset<string> FIELD_NAMES = keyset[
    'no_error',
    'user_facing_error',
    'hidden_exception',
    'non_nullable',
    'nested',
    'nested_nn',
    'bad_int_list_n_of_n',
    'bad_int_list_n_of_nn',
    'bad_int_list_nn_of_nn',
    'nested_list_n_of_n',
    'nested_list_n_of_nn',
    'nested_list_nn_of_nn',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'no_error':
        return new GraphQL\FieldDefinition(
          'no_error',
          Types\IntOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->no_error(),
        );
      case 'user_facing_error':
        return new GraphQL\FieldDefinition(
          'user_facing_error',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->user_facing_error(),
        );
      case 'hidden_exception':
        return new GraphQL\FieldDefinition(
          'hidden_exception',
          Types\IntOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->hidden_exception(),
        );
      case 'non_nullable':
        return new GraphQL\FieldDefinition(
          'non_nullable',
          Types\IntOutputType::nonNullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->non_nullable(),
        );
      case 'nested':
        return new GraphQL\FieldDefinition(
          'nested',
          ErrorTest::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->nested(),
        );
      case 'nested_nn':
        return new GraphQL\FieldDefinition(
          'nested_nn',
          ErrorTest::nonNullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->nested_nn(),
        );
      case 'bad_int_list_n_of_n':
        return new GraphQL\FieldDefinition(
          'bad_int_list_n_of_n',
          Types\IntOutputType::nullable()->nullableListOf(),
          async ($schema, $parent, $args, $vars) ==> $parent->bad_int_list_n_of_n(),
        );
      case 'bad_int_list_n_of_nn':
        return new GraphQL\FieldDefinition(
          'bad_int_list_n_of_nn',
          Types\IntOutputType::nonNullable()->nullableListOf(),
          async ($schema, $parent, $args, $vars) ==> $parent->bad_int_list_n_of_nn(),
        );
      case 'bad_int_list_nn_of_nn':
        return new GraphQL\FieldDefinition(
          'bad_int_list_nn_of_nn',
          Types\IntOutputType::nonNullable()->nonNullableListOf(),
          async ($schema, $parent, $args, $vars) ==> $parent->bad_int_list_nn_of_nn(),
        );
      case 'nested_list_n_of_n':
        return new GraphQL\FieldDefinition(
          'nested_list_n_of_n',
          ErrorTest::nullable()->nullableListOf(),
          async ($schema, $parent, $args, $vars) ==> $parent->nested_list_n_of_n(),
        );
      case 'nested_list_n_of_nn':
        return new GraphQL\FieldDefinition(
          'nested_list_n_of_nn',
          ErrorTest::nonNullable()->nullableListOf(),
          async ($schema, $parent, $args, $vars) ==> $parent->nested_list_n_of_nn(),
        );
      case 'nested_list_nn_of_nn':
        return new GraphQL\FieldDefinition(
          'nested_list_nn_of_nn',
          ErrorTest::nonNullable()->nonNullableListOf(),
          async ($schema, $parent, $args, $vars) ==> $parent->nested_list_nn_of_nn(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class Concrete extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \Concrete;
  const NAME = 'Concrete';
  const keyset<string> FIELD_NAMES = keyset[
    'foo',
    'bar',
    'baz',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'foo':
        return new GraphQL\FieldDefinition(
          'foo',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->foo(),
        );
      case 'bar':
        return new GraphQL\FieldDefinition(
          'bar',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->bar(),
        );
      case 'baz':
        return new GraphQL\FieldDefinition(
          'baz',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->baz(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class OutputTypeTest extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \OutputTypeTestObj;
  const NAME = 'OutputTypeTest';
  const keyset<string> FIELD_NAMES = keyset[
    'scalar',
    'nullable',
    'awaitable',
    'awaitable_nullable',
    'list',
    'awaitable_nullable_list',
    'nested_lists',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'scalar':
        return new GraphQL\FieldDefinition(
          'scalar',
          Types\IntOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->scalar(),
        );
      case 'nullable':
        return new GraphQL\FieldDefinition(
          'nullable',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->nullable(),
        );
      case 'awaitable':
        return new GraphQL\FieldDefinition(
          'awaitable',
          Types\IntOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> await $parent->awaitable(),
        );
      case 'awaitable_nullable':
        return new GraphQL\FieldDefinition(
          'awaitable_nullable',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> await $parent->awaitable_nullable(),
        );
      case 'list':
        return new GraphQL\FieldDefinition(
          'list',
          Types\StringOutputType::nonNullable()->nullableListOf(),
          async ($schema, $parent, $args, $vars) ==> $parent->list(),
        );
      case 'awaitable_nullable_list':
        return new GraphQL\FieldDefinition(
          'awaitable_nullable_list',
          Types\IntOutputType::nonNullable()->nullableListOf(),
          async ($schema, $parent, $args, $vars) ==> await $parent->awaitable_nullable_list(),
        );
      case 'nested_lists':
        return new GraphQL\FieldDefinition(
          'nested_lists',
          Types\IntOutputType::nullable()->nonNullableListOf()->nullableListOf()->nullableListOf(),
          async ($schema, $parent, $args, $vars) ==> $parent->nested_lists(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class Human extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \Human;
  const NAME = 'Human';
  const keyset<string> FIELD_NAMES = keyset[
    'id',
    'name',
    'team',
    'is_active',
    'favorite_color',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'id':
        return new GraphQL\FieldDefinition(
          'id',
          Types\IntOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getId(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getName(),
        );
      case 'team':
        return new GraphQL\FieldDefinition(
          'team',
          Team::nullable(),
          async ($schema, $parent, $args, $vars) ==> await $parent->getTeam(),
        );
      case 'is_active':
        return new GraphQL\FieldDefinition(
          'is_active',
          Types\BooleanOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->isActive(),
        );
      case 'favorite_color':
        return new GraphQL\FieldDefinition(
          'favorite_color',
          FavoriteColorOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getFavoriteColor(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class Bot extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \Bot;
  const NAME = 'Bot';
  const keyset<string> FIELD_NAMES = keyset[
    'id',
    'name',
    'team',
    'is_active',
    'primary_function',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'id':
        return new GraphQL\FieldDefinition(
          'id',
          Types\IntOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getId(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getName(),
        );
      case 'team':
        return new GraphQL\FieldDefinition(
          'team',
          Team::nullable(),
          async ($schema, $parent, $args, $vars) ==> await $parent->getTeam(),
        );
      case 'is_active':
        return new GraphQL\FieldDefinition(
          'is_active',
          Types\BooleanOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->isActive(),
        );
      case 'primary_function':
        return new GraphQL\FieldDefinition(
          'primary_function',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getPrimaryFunction(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class Team extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \Team;
  const NAME = 'Team';
  const keyset<string> FIELD_NAMES = keyset[
    'id',
    'name',
    'num_users',
    'description',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'id':
        return new GraphQL\FieldDefinition(
          'id',
          Types\IntOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getId(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getName(),
        );
      case 'num_users':
        return new GraphQL\FieldDefinition(
          'num_users',
          Types\IntOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> await $parent->getNumUsers(),
        );
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getDescription(
            Types\BooleanInputType::nonNullable()->coerceNode($args['short']->getValue(), $vars),
          ),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class __Schema extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \Slack\GraphQL\Introspection\__Schema;
  const NAME = '__Schema';
  const keyset<string> FIELD_NAMES = keyset[
    'types',
    'queryType',
    'mutationType',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'types':
        return new GraphQL\FieldDefinition(
          'types',
          __Type::nonNullable()->nullableListOf(),
          async ($schema, $parent, $args, $vars) ==> $parent->getTypes(),
        );
      case 'queryType':
        return new GraphQL\FieldDefinition(
          'queryType',
          __Type::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getQueryType(),
        );
      case 'mutationType':
        return new GraphQL\FieldDefinition(
          'mutationType',
          __Type::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getMutationType(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class __Type extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \Slack\GraphQL\Introspection\__Type;
  const NAME = '__Type';
  const keyset<string> FIELD_NAMES = keyset[
    'kind',
    'name',
    'description',
    'fields',
    'interfaces',
    'possibleTypes',
    'enumValues',
    'inputFields',
    'ofType',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'kind':
        return new GraphQL\FieldDefinition(
          'kind',
          __TypeKindOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getKind(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getName(),
        );
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getDescription(),
        );
      case 'fields':
        return new GraphQL\FieldDefinition(
          'fields',
          __Field::nonNullable()->nullableListOf(),
          async ($schema, $parent, $args, $vars) ==> $parent->getFields(),
        );
      case 'interfaces':
        return new GraphQL\FieldDefinition(
          'interfaces',
          __Type::nonNullable()->nullableListOf(),
          async ($schema, $parent, $args, $vars) ==> $parent->getInterfaces(),
        );
      case 'possibleTypes':
        return new GraphQL\FieldDefinition(
          'possibleTypes',
          __Type::nonNullable()->nullableListOf(),
          async ($schema, $parent, $args, $vars) ==> $parent->getPossibleTypes(),
        );
      case 'enumValues':
        return new GraphQL\FieldDefinition(
          'enumValues',
          __EnumValue::nonNullable()->nullableListOf(),
          async ($schema, $parent, $args, $vars) ==> $parent->getEnumValues(),
        );
      case 'inputFields':
        return new GraphQL\FieldDefinition(
          'inputFields',
          __InputValue::nonNullable()->nullableListOf(),
          async ($schema, $parent, $args, $vars) ==> $parent->getInputFields(),
        );
      case 'ofType':
        return new GraphQL\FieldDefinition(
          'ofType',
          __Type::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getOfType(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class __Field extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \Slack\GraphQL\Introspection\__Field;
  const NAME = '__Field';
  const keyset<string> FIELD_NAMES = keyset[
    'name',
    'description',
    'args',
    'type',
    'isDeprecated',
    'deprecationReason',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getName(),
        );
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getDescription(),
        );
      case 'args':
        return new GraphQL\FieldDefinition(
          'args',
          __InputValue::nonNullable()->nullableListOf(),
          async ($schema, $parent, $args, $vars) ==> $parent->getArgs(),
        );
      case 'type':
        return new GraphQL\FieldDefinition(
          'type',
          __Type::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getType(),
        );
      case 'isDeprecated':
        return new GraphQL\FieldDefinition(
          'isDeprecated',
          Types\BooleanOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->isDeprecated(),
        );
      case 'deprecationReason':
        return new GraphQL\FieldDefinition(
          'deprecationReason',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getDeprecationReason(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class __EnumValue extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \Slack\GraphQL\Introspection\__EnumValue;
  const NAME = '__EnumValue';
  const keyset<string> FIELD_NAMES = keyset[
    'name',
    'description',
    'isDeprecated',
    'deprecationReason',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getName(),
        );
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getDescription(),
        );
      case 'isDeprecated':
        return new GraphQL\FieldDefinition(
          'isDeprecated',
          Types\BooleanOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->isDeprecated(),
        );
      case 'deprecationReason':
        return new GraphQL\FieldDefinition(
          'deprecationReason',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getDeprecationReason(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}

final class __InputValue extends \Slack\GraphQL\Types\ObjectType {

  const type THackType = \Slack\GraphQL\Introspection\__InputValue;
  const NAME = '__InputValue';
  const keyset<string> FIELD_NAMES = keyset[
    'name',
    'description',
    'type',
    'defaultValue',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getName(),
        );
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getDescription(),
        );
      case 'type':
        return new GraphQL\FieldDefinition(
          'type',
          __Type::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getType(),
        );
      case 'defaultValue':
        return new GraphQL\FieldDefinition(
          'defaultValue',
          Types\StringOutputType::nullable(),
          async ($schema, $parent, $args, $vars) ==> $parent->getDefaultValue(),
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

final class __TypeKindInputType extends \Slack\GraphQL\Types\EnumInputType {

  const NAME = '__TypeKind';
  const type TCoerced = \Slack\GraphQL\Introspection\__TypeKind;
  const \HH\enumname<this::TCoerced> HACK_ENUM = \Slack\GraphQL\Introspection\__TypeKind::class;
}

final class __TypeKindOutputType extends \Slack\GraphQL\Types\EnumOutputType {

  const NAME = '__TypeKind';
  const type THackType = \Slack\GraphQL\Introspection\__TypeKind;
  const \HH\enumname<this::THackType> HACK_ENUM = \Slack\GraphQL\Introspection\__TypeKind::class;
}

final class CreateTeamInput extends \Slack\GraphQL\Types\InputObjectType {

  const type TCoerced = \TCreateTeamInput;
  const NAME = 'CreateTeamInput';
  const keyset<string> FIELD_NAMES = keyset[
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

  const type TCoerced = \TCreateUserInput;
  const NAME = 'CreateUserInput';
  const keyset<string> FIELD_NAMES = keyset[
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

abstract final class Schema extends \Slack\GraphQL\BaseSchema {

  const dict<string, classname<Types\NamedInputType>> INPUT_TYPES = dict[
    'Boolean' => Types\BooleanInputType::class,
    'CreateTeamInput' => CreateTeamInput::class,
    'CreateUserInput' => CreateUserInput::class,
    'FavoriteColor' => FavoriteColorInputType::class,
    'Int' => Types\IntInputType::class,
    'String' => Types\StringInputType::class,
    '__TypeKind' => __TypeKindInputType::class,
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
    '__EnumValue' => __EnumValue::class,
    '__Field' => __Field::class,
    '__InputValue' => __InputValue::class,
    '__Schema' => __Schema::class,
    '__Type' => __Type::class,
    '__TypeKind' => __TypeKindOutputType::class,
  ];
  const classname<\Slack\GraphQL\Types\ObjectType> QUERY_TYPE = Query::class;
  const classname<\Slack\GraphQL\Types\ObjectType> MUTATION_TYPE = Mutation::class;

  public static async function resolveQuery(
    \Graphpinator\Parser\Operation\Operation $operation,
    \Slack\GraphQL\Variables $variables,
  ): Awaitable<GraphQL\ValidFieldResult<?dict<string, mixed>>> {
    return await Query::nullable()->resolveAsync(self::class, new GraphQL\Root(), $operation, $variables);
  }

  public static async function resolveMutation(
    \Graphpinator\Parser\Operation\Operation $operation,
    \Slack\GraphQL\Variables $variables,
  ): Awaitable<GraphQL\ValidFieldResult<?dict<string, mixed>>> {
    return await Mutation::nullable()->resolveAsync(self::class, new GraphQL\Root(), $operation, $variables);
  }
}
