/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<598abb67a4fb26928a3e667038a80dc9>>
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
          User::nullable(),
          dict[
            'input' => shape(
              'name' => 'input',
              'type' => CreateUserInput::nonNullable(),
            ),
          ],
          async ($parent, $args, $vars) ==> await \UserMutationAttributes::createUser(
            CreateUserInput::nonNullable()->coerceNamedNode('input', $args, $vars),
          ),
        );
      case 'pokeUser':
        return new GraphQL\FieldDefinition(
          'pokeUser',
          User::nullable(),
          dict[
            'id' => shape(
              'name' => 'id',
              'type' => Types\IntInputType::nonNullable(),
            ),
          ],
          async ($parent, $args, $vars) ==> await \UserMutationAttributes::pokeUser(
            Types\IntInputType::nonNullable()->coerceNamedNode('id', $args, $vars),
          ),
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
      'description' => 'Mutation',
      'fields' => vec[
        shape(
          'name' => 'createUser',
          'description' => 'Create a new user',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'User')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'pokeUser',
          'description' => 'Poke a user by ID',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'User')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
      ],
    ));
  }
}
