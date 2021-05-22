/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<0deff4fc095c8eb5aa9d081a87a6cf59>>
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
  const keyset<classname<Types\InterfaceType>> INTERFACES = keyset[
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
        );
      case 'id':
        return new GraphQL\FieldDefinition(
          'id',
          Types\IntType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getId(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'num_users':
        return new GraphQL\FieldDefinition(
          'num_users',
          Types\IntType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->getNumUsers(),
        );
      default:
        return null;
    }
  }
}
