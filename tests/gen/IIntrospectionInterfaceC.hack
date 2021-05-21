/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<d06d895d4a7ab2979ee0cc35a2f46718>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class IIntrospectionInterfaceC
  extends \Slack\GraphQL\Types\InterfaceType {

  const NAME = 'IIntrospectionInterfaceC';
  const type THackType = \IIntrospectionInterfaceCDifferentClassNameThanGraphQLType;
  const keyset<string> FIELD_NAMES = keyset[
  ];
  const keyset<classname<Types\ObjectType>> POSSIBLE_TYPES = keyset[
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
