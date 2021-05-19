/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<37cfdd9ce48f8822dee71e8940028be7>>
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
          Types\StringOutputType::nullable(),
          dict[
            'short' => shape(
              'name' => 'short',
              'type' => Types\BooleanInputType::nonNullable(),
            ),
          ],
          async ($parent, $args, $vars) ==> $parent->getDescription(
            Types\BooleanInputType::nonNullable()->coerceNamedNode('short', $args, $vars),
          ),
        );
      case 'id':
        return new GraphQL\FieldDefinition(
          'id',
          Types\IntOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getId(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'num_users':
        return new GraphQL\FieldDefinition(
          'num_users',
          Types\IntOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->getNumUsers(),
        );
      default:
        return null;
    }
  }

  public static function introspect(
    GraphQL\Introspection\__Schema $schema,
  ): GraphQL\Introspection\NamedTypeDeclaration {
    return new GraphQL\Introspection\NamedTypeDeclaration(shape(
      'kind' => GraphQL\Introspection\__TypeKind::OBJECT,
      'name' => static::NAME,
      'description' => 'Team',
      'fields' => vec[
        shape(
          'name' => 'description',
          'description' => 'Description of the team',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'id',
          'description' => 'ID of the team',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'name',
          'description' => 'Name of the team',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'num_users',
          'description' => 'Number of users on the team',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
      ],
    ));
  }
}
