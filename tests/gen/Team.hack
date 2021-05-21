/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<128bf27b615580223595a54af02c21ed>>
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

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringType::nullableOutput($this->schema),
          dict[
            'short' => shape(
              'name' => 'short',
              'type' => Types\BooleanType::nonNullable($this->schema),
            ),
          ],
          async ($parent, $args, $vars) ==> $parent->getDescription(
            Types\BooleanType::nonNullable($this->schema)->coerceNamedNode('short', $args, $vars),
          ),
        );
      case 'id':
        return new GraphQL\FieldDefinition(
          'id',
          Types\IntType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getId(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'num_users':
        return new GraphQL\FieldDefinition(
          'num_users',
          Types\IntType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->getNumUsers(),
        );
      default:
        return null;
    }
  }
}
