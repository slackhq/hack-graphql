/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<7278e6c4fe3c36b748959101699073fc>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class IIntrospectionInterfaceB
  extends \Slack\GraphQL\Types\InterfaceType {

  const NAME = 'IIntrospectionInterfaceB';
  const type THackType = \IIntrospectionInterfaceB;
  const keyset<string> FIELD_NAMES = keyset[
  ];
  const keyset<string> POSSIBLE_TYPES = keyset[
    'ImplementInterfaceB',
    'ImplementInterfaceC',
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
    \Graphpinator\Parser\Field\IHasFieldSet $field,
    GraphQL\Variables $vars,
  ): Awaitable<GraphQL\FieldResult<dict<string, mixed>>> {
    if ($value is \ImplementInterfaceB) {
      return await ImplementInterfaceB::nonNullable($this->schema)->resolveAsync($value, $field, $vars);
    }
    if ($value is \ImplementInterfaceC) {
      return await ImplementInterfaceC::nonNullable($this->schema)->resolveAsync($value, $field, $vars);
    }
    invariant_violation(
      'Class %s has no associated GraphQL type or it is not a subtype of %s.',
      \get_class($value),
      static::NAME,
    );
  }
}
