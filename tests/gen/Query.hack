/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<e1f73d505cc98498082c3ef36f9aae9b>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Query extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Query';
  const type THackType = \Slack\GraphQL\Root;

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'arg_test':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> \ArgumentTestObj::argTest(
            Types\IntInputType::nonNullable()->coerceNamedNode('required', $args, $vars),
            Types\IntInputType::nullable()->coerceNamedNode('nullable', $args, $vars),
            Types\IntInputType::nullable()->coerceOptionalNamedNode('optional', $args, $vars, 42),
          ),
        );
      case 'bot':
        return new GraphQL\FieldDefinition(
          Bot::nullable(),
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getBot(
            Types\IntInputType::nonNullable()->coerceNamedNode('id', $args, $vars),
          ),
        );
      case 'error_test':
        return new GraphQL\FieldDefinition(
          ErrorTestObj::nullable(),
          async ($parent, $args, $vars) ==> \ErrorTestObj::get(),
        );
      case 'error_test_nn':
        return new GraphQL\FieldDefinition(
          ErrorTestObj::nonNullable(),
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
      case 'human':
        return new GraphQL\FieldDefinition(
          Human::nullable(),
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getHuman(
            Types\IntInputType::nonNullable()->coerceNamedNode('id', $args, $vars),
          ),
        );
      case 'list_arg_test':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nonNullable()->nullableListOf()->nullableListOf()->nullableListOf(),
          async ($parent, $args, $vars) ==> \ArgumentTestObj::listArgTest(
            Types\IntInputType::nonNullable()->nullableListOf()->nonNullableListOf()->nullableListOf()->coerceNamedNode('arg', $args, $vars),
          ),
        );
      case 'nested_list_sum':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nullable(),
          async ($parent, $args, $vars) ==> \UserQueryAttributes::getNestedListSum(
            Types\IntInputType::nonNullable()->nonNullableListOf()->nonNullableListOf()->coerceNamedNode('numbers', $args, $vars),
          ),
        );
      case 'optional_field_test':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> \UserQueryAttributes::optionalFieldTest(
            CreateUserInput::nonNullable()->coerceNamedNode('input', $args, $vars),
          ),
        );
      case 'output_type_test':
        return new GraphQL\FieldDefinition(
          OutputTypeTestObj::nullable(),
          async ($parent, $args, $vars) ==> \OutputTypeTestObj::get(),
        );
      case 'takes_favorite_color':
        return new GraphQL\FieldDefinition(
          Types\BooleanOutputType::nullable(),
          async ($parent, $args, $vars) ==> \UserQueryAttributes::takesFavoriteColor(
            FavoriteColorInputType::nonNullable()->coerceNamedNode('favorite_color', $args, $vars),
          ),
        );
      case 'user':
        return new GraphQL\FieldDefinition(
          User::nullable(),
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getUser(
            Types\IntInputType::nonNullable()->coerceNamedNode('id', $args, $vars),
          ),
        );
      case 'viewer':
        return new GraphQL\FieldDefinition(
          User::nullable(),
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getViewer(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}
