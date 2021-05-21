/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<2692931475deaf2db40669c79479288f>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class InterfaceA extends \Slack\GraphQL\Types\InterfaceType {

  const NAME = 'InterfaceA';
  const type THackType = \InterfaceA;
  const keyset<string> FIELD_NAMES = keyset[
    'foo',
  ];
  const keyset<classname<Types\ObjectType>> POSSIBLE_TYPES = keyset[
    Concrete::class,
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'foo':
        return new GraphQL\FieldDefinition(
          'foo',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->foo(),
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
    if ($value is \Concrete) {
      return await Concrete::nonNullable()->resolveAsync($value, $parent_nodes, $context);
    }
    invariant_violation(
      'Class %s has no associated GraphQL type or it is not a subtype of %s.',
      \get_class($value),
      static::NAME,
    );
  }
}
