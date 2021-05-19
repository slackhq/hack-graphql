/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<bc00fd9d638b0f91e3bcea4ea370b17a>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class User extends \Slack\GraphQL\Types\InterfaceType {

  const NAME = 'User';
  const type THackType = \User;
  const keyset<string> FIELD_NAMES = keyset[
    'id',
    'is_active',
    'name',
    'team',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
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
      'kind' => GraphQL\Introspection\__TypeKind::INTERFACE,
      'name' => static::NAME,
      'description' => 'User',
      'fields' => vec[
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

  public async function resolveAsync(
    this::THackType $value,
    \Graphpinator\Parser\Field\IHasFieldSet $field,
    GraphQL\Variables $vars,
  ): Awaitable<GraphQL\FieldResult<dict<string, mixed>>> {
    if ($value is \Bot) {
      return await Bot::nonNullable()->resolveAsync($value, $field, $vars);
    }
    if ($value is \Human) {
      return await Human::nonNullable()->resolveAsync($value, $field, $vars);
    }
    invariant_violation(
      'Class %s has no associated GraphQL type or it is not a subtype of %s.',
      \get_class($value),
      static::NAME,
    );
  }
}
