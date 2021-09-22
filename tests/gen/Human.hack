/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<6dcb233c0846538dfa0a620a12aee762>>
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
          'Favorite color of the user',
          null,
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
          'Friends',
          null,
        );
      case 'id':
        return new GraphQL\FieldDefinition(
          'id',
          Types\IntType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getId(),
          'ID of the user',
          null,
        );
      case 'is_active':
        return new GraphQL\FieldDefinition(
          'is_active',
          Types\BooleanType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->isActive(),
          'Whether the user is active',
          null,
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getName(),
          'Name of the user',
          null,
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
          'Test that we can pass args to a field which returns a connection',
          null,
        );
      case 'team':
        return new GraphQL\FieldDefinition(
          'team',
          Team::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->getTeam(),
          'Team the user belongs to',
          null,
        );
      default:
        return null;
    }
  }
}
