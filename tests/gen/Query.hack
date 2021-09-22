/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<067275aa67c4d0b5123b0d4bec136ff8>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Query extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Query';
  const type THackType = \Slack\GraphQL\Root;
  const keyset<string> FIELD_NAMES = keyset[
    'alphabetConnection',
    'arg_test',
    'bot',
    'error_test',
    'error_test_nn',
    'getConcrete',
    'getInterfaceA',
    'getInterfaceB',
    'getObjectShape',
    'human',
    'introspection_test',
    'list_arg_test',
    'nested_list_sum',
    'optional_field_test',
    'output_type_test',
    'takes_favorite_color',
    'user',
    'viewer',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case '__schema':
        return new GraphQL\FieldDefinition(
          '__schema',
          __Schema::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> new Schema(),
          null,
          false,
          null,
        );
      case '__type':
        return new GraphQL\FieldDefinition(
          '__type',
          __Type::nullableOutput(),
          dict[
            'name' => shape(
              'name' => 'name',
              'type' => Types\StringType::nonNullable(),
            ),
          ],
          async ($parent, $args, $vars) ==> (new Schema())->getIntrospectionType(

            Types\StringType::nonNullable()->coerceNamedNode('name', $args, $vars),
          ),
          null,
          false,
          null,
        );
      case 'alphabetConnection':
        return new GraphQL\FieldDefinition(
          'alphabetConnection',
          AlphabetConnection::nullableOutput(),
          dict[
            'after' => shape(
              'name' => 'after',
              'type' => Types\StringType::nullableInput(),
              'defaultValue' => 'null',
            ),
            'before' => shape(
              'name' => 'before',
              'type' => Types\StringType::nullableInput(),
              'defaultValue' => 'null',
            ),
            'first' => shape(
              'name' => 'first',
              'type' => Types\IntType::nullableInput(),
              'defaultValue' => 'null',
            ),
            'last' => shape(
              'name' => 'last',
              'type' => Types\IntType::nullableInput(),
              'defaultValue' => 'null',
            ),
          ],
          async ($parent, $args, $vars) ==> \UserQueryAttributes::alphabetConnection()->setPaginationArgs(
            Types\StringType::nullableInput()->coerceOptionalNamedNode('after', $args, $vars, null),
            Types\StringType::nullableInput()->coerceOptionalNamedNode('before', $args, $vars, null),
            Types\IntType::nullableInput()->coerceOptionalNamedNode('first', $args, $vars, null),
            Types\IntType::nullableInput()->coerceOptionalNamedNode('last', $args, $vars, null),
          ),
          'Test for list connection',
          false,
          null,
        );
      case 'arg_test':
        return new GraphQL\FieldDefinition(
          'arg_test',
          Types\IntType::nullableOutput()->nullableOutputListOf(),
          dict[
            'required' => shape(
              'name' => 'required',
              'type' => Types\IntType::nonNullable(),
            ),
            'nullable' => shape(
              'name' => 'nullable',
              'type' => Types\IntType::nullableInput(),
            ),
            'optional' => shape(
              'name' => 'optional',
              'type' => Types\IntType::nullableInput(),
              'defaultValue' => '42',
            ),
          ],
          async ($parent, $args, $vars) ==> \ArgumentTestObj::argTest(
            Types\IntType::nonNullable()->coerceNamedNode('required', $args, $vars),
            Types\IntType::nullableInput()->coerceNamedNode('nullable', $args, $vars),
            Types\IntType::nullableInput()->coerceOptionalNamedNode('optional', $args, $vars, 42),
          ),
          'Root field for testing arguments',
          false,
          null,
        );
      case 'bot':
        return new GraphQL\FieldDefinition(
          'bot',
          Bot::nullableOutput(),
          dict[
            'id' => shape(
              'name' => 'id',
              'type' => Types\IntType::nonNullable(),
            ),
          ],
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getBot(
            Types\IntType::nonNullable()->coerceNamedNode('id', $args, $vars),
          ),
          'Fetch a bot by ID',
          false,
          null,
        );
      case 'error_test':
        return new GraphQL\FieldDefinition(
          'error_test',
          ErrorTestObj::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> \ErrorTestObj::get(),
          'Root field to get an instance',
          false,
          null,
        );
      case 'error_test_nn':
        return new GraphQL\FieldDefinition(
          'error_test_nn',
          ErrorTestObj::nonNullable(),
          dict[],
          async ($parent, $args, $vars) ==> \ErrorTestObj::getNonNullable(),
          'A non-nullable root field to get an instance',
          false,
          null,
        );
      case 'getConcrete':
        return new GraphQL\FieldDefinition(
          'getConcrete',
          Concrete::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> \Concrete::getConcrete(),
          'Root field to get an instance of Concrete',
          false,
          null,
        );
      case 'getInterfaceA':
        return new GraphQL\FieldDefinition(
          'getInterfaceA',
          InterfaceA::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> \Concrete::getInterfaceA(),
          'Root field to get an instance of InterfaceA',
          false,
          null,
        );
      case 'getInterfaceB':
        return new GraphQL\FieldDefinition(
          'getInterfaceB',
          InterfaceB::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> \Concrete::getInterfaceB(),
          'Root field to get an instance of InterfaceB',
          false,
          null,
        );
      case 'getObjectShape':
        return new GraphQL\FieldDefinition(
          'getObjectShape',
          ObjectShape::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> \ObjectTypeTestEntrypoint::getObjectShape(),
          'fetch an object shape',
          false,
          null,
        );
      case 'human':
        return new GraphQL\FieldDefinition(
          'human',
          Human::nullableOutput(),
          dict[
            'id' => shape(
              'name' => 'id',
              'type' => Types\IntType::nonNullable(),
            ),
          ],
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getHuman(
            Types\IntType::nonNullable()->coerceNamedNode('id', $args, $vars),
          ),
          'Fetch a user by ID',
          false,
          null,
        );
      case 'introspection_test':
        return new GraphQL\FieldDefinition(
          'introspection_test',
          IntrospectionTestObject::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> \IntrospectionTestObject::get(),
          'Root field to get an instance',
          false,
          null,
        );
      case 'list_arg_test':
        return new GraphQL\FieldDefinition(
          'list_arg_test',
          Types\IntType::nonNullable()->nullableOutputListOf()->nullableOutputListOf()->nullableOutputListOf(),
          dict[
            'arg' => shape(
              'name' => 'arg',
              'type' => Types\IntType::nonNullable()->nullableInputListOf()->nonNullableInputListOf()->nullableInputListOf(),
            ),
          ],
          async ($parent, $args, $vars) ==> \ArgumentTestObj::listArgTest(
            Types\IntType::nonNullable()->nullableInputListOf()->nonNullableInputListOf()->nullableInputListOf()->coerceNamedNode('arg', $args, $vars),
          ),
          'Root field for testing list arguments',
          false,
          null,
        );
      case 'nested_list_sum':
        return new GraphQL\FieldDefinition(
          'nested_list_sum',
          Types\IntType::nullableOutput(),
          dict[
            'numbers' => shape(
              'name' => 'numbers',
              'type' => Types\IntType::nonNullable()->nonNullableInputListOf()->nonNullableInputListOf(),
            ),
          ],
          async ($parent, $args, $vars) ==> \UserQueryAttributes::getNestedListSum(
            Types\IntType::nonNullable()->nonNullableInputListOf()->nonNullableInputListOf()->coerceNamedNode('numbers', $args, $vars),
          ),
          'Test for nested list arguments',
          false,
          null,
        );
      case 'optional_field_test':
        return new GraphQL\FieldDefinition(
          'optional_field_test',
          Types\StringType::nullableOutput(),
          dict[
            'input' => shape(
              'name' => 'input',
              'type' => CreateUserInput::nonNullable(),
            ),
          ],
          async ($parent, $args, $vars) ==> \UserQueryAttributes::optionalFieldTest(
            CreateUserInput::nonNullable()->coerceNamedNode('input', $args, $vars),
          ),
          'Test for an optional input object field',
          false,
          null,
        );
      case 'output_type_test':
        return new GraphQL\FieldDefinition(
          'output_type_test',
          OutputTypeTestObj::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> \OutputTypeTestObj::get(),
          'Root field to get an instance',
          false,
          null,
        );
      case 'takes_favorite_color':
        return new GraphQL\FieldDefinition(
          'takes_favorite_color',
          Types\BooleanType::nullableOutput(),
          dict[
            'favorite_color' => shape(
              'name' => 'favorite_color',
              'type' => FavoriteColor::nonNullable(),
            ),
          ],
          async ($parent, $args, $vars) ==> \UserQueryAttributes::takesFavoriteColor(
            FavoriteColor::nonNullable()->coerceNamedNode('favorite_color', $args, $vars),
          ),
          'Test for enum arguments',
          false,
          null,
        );
      case 'user':
        return new GraphQL\FieldDefinition(
          'user',
          User::nullableOutput(),
          dict[
            'id' => shape(
              'name' => 'id',
              'type' => Types\IntType::nonNullable(),
            ),
          ],
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getUser(
            Types\IntType::nonNullable()->coerceNamedNode('id', $args, $vars),
          ),
          'Fetch a user by ID',
          false,
          null,
        );
      case 'viewer':
        return new GraphQL\FieldDefinition(
          'viewer',
          User::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getViewer(),
          'Authenticated viewer',
          false,
          null,
        );
      default:
        return null;
    }
  }
}
