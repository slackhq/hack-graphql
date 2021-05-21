/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<83c4ac9e30bde4ce823ffcb02f4260a4>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class IIntrospectionInterfaceA
  extends \Slack\GraphQL\Types\InterfaceType {

  const NAME = 'IIntrospectionInterfaceA';
  const type THackType = \IIntrospectionInterfaceA;
  const keyset<string> FIELD_NAMES = keyset[
  ];
  const keyset<classname<Types\ObjectType>> POSSIBLE_TYPES = keyset[
    ImplementInterfaceA::class,
    ImplementInterfaceB::class,
    ImplementInterfaceC::class,
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      default:
        return null;
    }
  }

  public async function resolveAsync(
    this::THackType $value,
    vec<\Graphpinator\Parser\Field\IHasSelectionSet> $parent_nodes,
    \Slack\GraphQL\ExecutionContext $context,
  ): Awaitable<GraphQL\FieldResult<dict<string, mixed>>> {
    if ($value is \ImplementInterfaceA) {
      return await ImplementInterfaceA::nonNullable()->resolveAsync($value, $parent_nodes, $context);
    }
    if ($value is \ImplementInterfaceB) {
      return await ImplementInterfaceB::nonNullable()->resolveAsync($value, $parent_nodes, $context);
    }
    if ($value is \ImplementInterfaceC) {
      return await ImplementInterfaceC::nonNullable()->resolveAsync($value, $parent_nodes, $context);
    }
    invariant_violation(
      'Class %s has no associated GraphQL type or it is not a subtype of %s.',
      \get_class($value),
      static::NAME,
    );
  }
}
