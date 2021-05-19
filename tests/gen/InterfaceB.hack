/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<7956e85b1e1b93d31f1671cde5911de5>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class InterfaceB extends \Slack\GraphQL\Types\InterfaceType {

  const NAME = 'InterfaceB';
  const type THackType = \InterfaceB;
  const keyset<string> FIELD_NAMES = keyset[
    'bar',
    'foo',
  ];

  <<__Override>>
  public function getDescription(): ?string {
    return 'InterfaceB';
  }

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'bar':
        return new GraphQL\FieldDefinition(
          'bar',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->bar(),
        );
      case 'foo':
        return new GraphQL\FieldDefinition(
          'foo',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->foo(),
        );
      default:
        return null;
    }
  }

  public async function resolveAsync(
    this::THackType $value,
    \Graphpinator\Parser\Field\IHasFieldSet $field,
    GraphQL\Variables $vars,
  ): Awaitable<GraphQL\FieldResult<dict<string, mixed>>> {
    if ($value is \Concrete) {
      return await Concrete::nonNullable()->resolveAsync($value, $field, $vars);
    }
    invariant_violation(
      'Class %s has no associated GraphQL type or it is not a subtype of %s.',
      \get_class($value),
      static::NAME,
    );
  }
}
