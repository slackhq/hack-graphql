/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<7ea97f7c9dbc2d43a4cb74d7fd481c6f>>
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
          vec[
            new \Directives\AnotherDirective(),
            new \Directives\HasRole(vec[\Directives\StaffRoleType::class]),
            new \Directives\LogSampled(33.300000, "foo"),
            new \Directives\TestShapeDirective(shape('foo' => 1, 'bar' => "abc"), true),
          ],
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
          vec[],
        );
      case 'id':
        return new GraphQL\FieldDefinition(
          'id',
          Types\IntType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getId(),
          vec[],
        );
      case 'is_active':
        return new GraphQL\FieldDefinition(
          'is_active',
          Types\BooleanType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->isActive(),
          vec[],
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getName(),
          vec[],
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
          vec[],
        );
      case 'team':
        return new GraphQL\FieldDefinition(
          'team',
          Team::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->getTeam(),
          vec[],
        );
      default:
        return null;
    }
  }

  public function getDirectives(): vec<GraphQL\ObjectDirective> {
    return vec[
      new \Directives\AnotherDirective(),
      new \Directives\HasRole(vec[\Directives\AdminRoleType::class]),
      new \Directives\LogSampled(0.000000, "bar"),
    ];
  }
}
