/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<3f80380271d776f8efd8825d50e067d7>>
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
  const keyset<classname<Types\ObjectType>> POSSIBLE_TYPES = keyset[
    Bot::class,
    Human::class,
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
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

  public async function resolveAsync(
    this::THackType $value,
    vec<\Graphpinator\Parser\Field\IHasSelectionSet> $parent_nodes,
    \Slack\GraphQL\ExecutionContext $context,
  ): Awaitable<GraphQL\FieldResult<dict<string, mixed>>> {
    if ($value is \Bot) {
      return await Bot::nonNullable()->resolveAsync($value, $parent_nodes, $context);
    }
    if ($value is \Human) {
      return await Human::nonNullable()->resolveAsync($value, $parent_nodes, $context);
    }
    invariant_violation(
      'Class %s has no associated GraphQL type or it is not a subtype of %s.',
      \get_class($value),
      static::NAME,
    );
  }
}
