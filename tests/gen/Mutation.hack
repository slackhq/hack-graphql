/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<d79dead259711aa4e0373e7dff969f9a>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Mutation extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Mutation';
  const type THackType = \Slack\GraphQL\Root;

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'createUser':
        return new GraphQL\FieldDefinition(
          User::nullable(),
          async ($parent, $args, $vars) ==> await \UserMutationAttributes::createUser(
            CreateUserInput::nonNullable()->coerceNamedNode('input', $args, $vars),
          ),
        );
      case 'pokeUser':
        return new GraphQL\FieldDefinition(
          User::nullable(),
          async ($parent, $args, $vars) ==> await \UserMutationAttributes::pokeUser(
            Types\IntInputType::nonNullable()->coerceNamedNode('id', $args, $vars),
          ),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}
