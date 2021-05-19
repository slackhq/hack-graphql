/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<c93b04d3296510b7731e3b79a3922472>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Query extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Query';
  const type THackType = \Slack\GraphQL\Root;
  const keyset<string> FIELD_NAMES = keyset[
    '__schema',
    '__type',
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

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case '__schema':
        return new GraphQL\FieldDefinition(
          '__schema',
          __Schema::nullable(),
          async ($parent, $args, $vars) ==> \Slack\GraphQL\Introspection\QueryRootFields::getSchema(),
        );
      case '__type':
        return new GraphQL\FieldDefinition(
          '__type',
          Introspection\__Type::nullable(),
          async ($parent, $args, $vars) ==> \Slack\GraphQL\Introspection\QueryRootFields::getType(
            Types\StringInputType::nonNullable()->coerceNamedNode('name', $args, $vars),
          ),
        );
      case 'arg_test':
        return new GraphQL\FieldDefinition(
          'arg_test',
          Types\IntOutputType::nullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> \ArgumentTestObj::argTest(
            Types\IntInputType::nonNullable()->coerceNamedNode('required', $args, $vars),
            Types\IntInputType::nullable()->coerceNamedNode('nullable', $args, $vars),
            Types\IntInputType::nullable()->coerceOptionalNamedNode('optional', $args, $vars, 42),
          ),
        );
      case 'bot':
        return new GraphQL\FieldDefinition(
          'bot',
          Bot::nullable(),
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getBot(
            Types\IntInputType::nonNullable()->coerceNamedNode('id', $args, $vars),
          ),
        );
      case 'error_test':
        return new GraphQL\FieldDefinition(
          'error_test',
          ErrorTestObj::nullable(),
          async ($parent, $args, $vars) ==> \ErrorTestObj::get(),
        );
      case 'error_test_nn':
        return new GraphQL\FieldDefinition(
          'error_test_nn',
          ErrorTestObj::nonNullable(),
          async ($parent, $args, $vars) ==> \ErrorTestObj::getNonNullable(),
        );
      case 'getConcrete':
        return new GraphQL\FieldDefinition(
          'getConcrete',
          Concrete::nullable(),
          async ($parent, $args, $vars) ==> \Concrete::getConcrete(),
        );
      case 'getInterfaceA':
        return new GraphQL\FieldDefinition(
          'getInterfaceA',
          InterfaceA::nullable(),
          async ($parent, $args, $vars) ==> \Concrete::getInterfaceA(),
        );
      case 'getInterfaceB':
        return new GraphQL\FieldDefinition(
          'getInterfaceB',
          InterfaceB::nullable(),
          async ($parent, $args, $vars) ==> \Concrete::getInterfaceB(),
        );
      case 'getObjectShape':
        return new GraphQL\FieldDefinition(
          'getObjectShape',
          ObjectShape::nullable(),
          async ($parent, $args, $vars) ==> \ObjectTypeTestEntrypoint::getObjectShape(),
        );
      case 'human':
        return new GraphQL\FieldDefinition(
          'human',
          Human::nullable(),
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getHuman(
            Types\IntInputType::nonNullable()->coerceNamedNode('id', $args, $vars),
          ),
        );
      case 'introspection_test':
        return new GraphQL\FieldDefinition(
          'introspection_test',
          IntrospectionTestObject::nullable(),
          async ($parent, $args, $vars) ==> \IntrospectionTestObject::get(),
        );
      case 'list_arg_test':
        return new GraphQL\FieldDefinition(
          'list_arg_test',
          Types\IntOutputType::nonNullable()->nullableListOf()->nullableListOf()->nullableListOf(),
          async ($parent, $args, $vars) ==> \ArgumentTestObj::listArgTest(
            Types\IntInputType::nonNullable()->nullableListOf()->nonNullableListOf()->nullableListOf()->coerceNamedNode('arg', $args, $vars),
          ),
        );
      case 'nested_list_sum':
        return new GraphQL\FieldDefinition(
          'nested_list_sum',
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> \UserQueryAttributes::getNestedListSum(
            Types\IntInputType::nonNullable()->nonNullableListOf()->nonNullableListOf()->coerceNamedNode('numbers', $args, $vars),
          ),
        );
      case 'optional_field_test':
        return new GraphQL\FieldDefinition(
          'optional_field_test',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> \UserQueryAttributes::optionalFieldTest(
            CreateUserInput::nonNullable()->coerceNamedNode('input', $args, $vars),
          ),
        );
      case 'output_type_test':
        return new GraphQL\FieldDefinition(
          'output_type_test',
          OutputTypeTestObj::nullable(),
          async ($parent, $args, $vars) ==> \OutputTypeTestObj::get(),
        );
      case 'takes_favorite_color':
        return new GraphQL\FieldDefinition(
          'takes_favorite_color',
          Types\BooleanOutputType::nullable(),
          async ($parent, $args, $vars) ==> \UserQueryAttributes::takesFavoriteColor(
            FavoriteColorInputType::nonNullable()->coerceNamedNode('favorite_color', $args, $vars),
          ),
        );
      case 'user':
        return new GraphQL\FieldDefinition(
          'user',
          User::nullable(),
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getUser(
            Types\IntInputType::nonNullable()->coerceNamedNode('id', $args, $vars),
          ),
        );
      case 'viewer':
        return new GraphQL\FieldDefinition(
          'viewer',
          User::nullable(),
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getViewer(),
        );
      default:
        return null;
    }
  }
}
