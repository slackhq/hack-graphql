/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<fb5cde473083f4b7b6bc96b1b5ee162a>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Mutation extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Mutation';
  const type THackType = \Slack\GraphQL\Root;
  const keyset<string> FIELD_NAMES = keyset[
    'createUser',
    'pokeUser',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'createUser':
        return new GraphQL\FieldDefinition(
          'createUser',
          User::nullableOutput($this->schema),
          dict[
            'input' => shape(
              'name' => 'input',
              'type' => CreateUserInput::nonNullable($this->schema),
            ),
          ],
          async ($parent, $args, $vars) ==> await \UserMutationAttributes::createUser(
            CreateUserInput::nonNullable($this->schema)->coerceNamedNode('input', $args, $vars),
          ),
        );
      case 'pokeUser':
        return new GraphQL\FieldDefinition(
          'pokeUser',
          User::nullableOutput($this->schema),
          dict[
            'id' => shape(
              'name' => 'id',
              'type' => Types\IntType::nonNullable($this->schema),
            ),
          ],
          async ($parent, $args, $vars) ==> await \UserMutationAttributes::pokeUser(
            Types\IntType::nonNullable($this->schema)->coerceNamedNode('id', $args, $vars),
          ),
        );
      default:
        return null;
    }
  }
}
