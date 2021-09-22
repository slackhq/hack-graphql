/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<4f9d8cbae367577036392dff97a6275d>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Team extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Team';
  const type THackType = \Team;
  const keyset<string> FIELD_NAMES = keyset[
    'description',
    'id',
    'name',
    'num_users',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringType::nullableOutput(),
          dict[
            'short' => shape(
              'name' => 'short',
              'type' => Types\BooleanType::nonNullable(),
            ),
          ],
          async ($parent, $args, $vars) ==> $parent->getDescription(
            Types\BooleanType::nonNullable()->coerceNamedNode('short', $args, $vars),
          ),
          'Description of the team',
          false,
          null,
        );
      case 'id':
        return new GraphQL\FieldDefinition(
          'id',
          Types\IntType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getId(),
          'ID of the team',
          false,
          null,
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getName(),
          'Name of the team',
          false,
          null,
        );
      case 'num_users':
        return new GraphQL\FieldDefinition(
          'num_users',
          Types\IntType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->getNumUsers(),
          'Number of users on the team',
          false,
          null,
        );
      default:
        return null;
    }
  }
}
