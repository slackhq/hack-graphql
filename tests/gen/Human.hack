/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<74cee04a80f9d7fcba46fd5b48e66987>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Human extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Human';
  const type THackType = \Human;
  const keyset<string> FIELD_NAMES = keyset[
    'favorite_color',
    'friends',
    'id',
    'is_active',
    'name',
    'named_friends',
    'roles',
    'team',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
    'User' => User::class,
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'favorite_color':
        return new GraphQL\FieldDefinition(
          'favorite_color',
          FavoriteColor::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getFavoriteColor(),
        );
      case 'friends':
        return new GraphQL\FieldDefinition(
          'friends',
          UserConnection::nullableOutput(),
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
          async ($parent, $args, $vars) ==> (await $parent->getFriends())->setPaginationArgs(
            Types\StringType::nullableInput()->coerceOptionalNamedNode('after', $args, $vars, null),
            Types\StringType::nullableInput()->coerceOptionalNamedNode('before', $args, $vars, null),
            Types\IntType::nullableInput()->coerceOptionalNamedNode('first', $args, $vars, null),
            Types\IntType::nullableInput()->coerceOptionalNamedNode('last', $args, $vars, null),
          ),
        );
      case 'id':
        return new GraphQL\FieldDefinition(
          'id',
          Types\IntType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getId(),
        );
      case 'is_active':
        return new GraphQL\FieldDefinition(
          'is_active',
          Types\BooleanType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->isActive(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'named_friends':
        return new GraphQL\FieldDefinition(
          'named_friends',
          UserConnection::nullableOutput(),
          dict[
            'name_prefix' => shape(
              'name' => 'name_prefix',
              'type' => Types\StringType::nonNullable(),
            ),
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
          async ($parent, $args, $vars) ==> (await $parent->getFriendsWithArg(
            Types\StringType::nonNullable()->coerceNamedNode('name_prefix', $args, $vars),
          ))->setPaginationArgs(
            Types\StringType::nullableInput()->coerceOptionalNamedNode('after', $args, $vars, null),
            Types\StringType::nullableInput()->coerceOptionalNamedNode('before', $args, $vars, null),
            Types\IntType::nullableInput()->coerceOptionalNamedNode('first', $args, $vars, null),
            Types\IntType::nullableInput()->coerceOptionalNamedNode('last', $args, $vars, null),
          ),
        );
      case 'roles':
        return new GraphQL\FieldDefinition(
          'roles',
          Role::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getRoles(),
        );
      case 'team':
        return new GraphQL\FieldDefinition(
          'team',
          Team::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->getTeam(),
        );
      default:
        return null;
    }
  }
}
