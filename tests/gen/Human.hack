/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<a2d8fa756e3bfb33149300ce7fe64963>>
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
    'id',
    'is_active',
    'name',
    'team',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'favorite_color':
        return new GraphQL\FieldDefinition(
          'favorite_color',
          FavoriteColorOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getFavoriteColor(),
        );
      case 'id':
        return new GraphQL\FieldDefinition(
          'id',
          Types\IntOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getId(),
        );
      case 'is_active':
        return new GraphQL\FieldDefinition(
          'is_active',
          Types\BooleanOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->isActive(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'team':
        return new GraphQL\FieldDefinition(
          'team',
          Team::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->getTeam(),
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
      'description' => 'Human',
      'fields' => vec[
        shape(
          'name' => 'favorite_color',
          'description' => 'Favorite color of the user',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'FavoriteColorOutputType')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'id',
          'description' => 'ID of the user',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'is_active',
          'description' => 'Whether the user is active',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Boolean')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'name',
          'description' => 'Name of the user',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'team',
          'description' => 'Team the user belongs to',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Team')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
      ],
    ));
  }
}
