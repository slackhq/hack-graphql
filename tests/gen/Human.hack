/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<8a9e54d5c6e7d11e6a80d9a903886b6e>>
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
        );
      case 'friends':
        return new GraphQL\FieldDefinition(
          'friends',
          UserConnection::nullableOutput(),
          dict[
            'after' => shape(
              'name' => 'after',
              'type' => Types\StringType::nullableInput(),
              'default_value' => null,
            ),
            'before' => shape(
              'name' => 'before',
              'type' => Types\StringType::nullableInput(),
              'default_value' => null,
            ),
            'first' => shape(
              'name' => 'first',
              'type' => Types\IntType::nullableInput(),
              'default_value' => null,
            ),
            'last' => shape(
              'name' => 'last',
              'type' => Types\IntType::nullableInput(),
              'default_value' => null,
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
              'default_value' => null,
            ),
            'before' => shape(
              'name' => 'before',
              'type' => Types\StringType::nullableInput(),
              'default_value' => null,
            ),
            'first' => shape(
              'name' => 'first',
              'type' => Types\IntType::nullableInput(),
              'default_value' => null,
            ),
            'last' => shape(
              'name' => 'last',
              'type' => Types\IntType::nullableInput(),
              'default_value' => null,
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
      case 'team':
        return new GraphQL\FieldDefinition(
          'team',
          Team::nonNullable()->promise(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getTeam(),
        );
      default:
        return null;
    }
  }
}
