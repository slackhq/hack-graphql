/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<312b5197df4461595cab71ab449fbb0d>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class CreateTeamInput extends \Slack\GraphQL\Types\InputObjectType {

  const NAME = 'CreateTeamInput';
  const type THackType = \TCreateTeamInput;
  const keyset<string> FIELD_NAMES = keyset [
    'name',
  ];

  <<__Override>>
  public function coerceFieldValues(
    KeyedContainer<arraykey, mixed> $fields,
  ): this::THackType {
    $ret = shape();
    $ret['name'] = Types\StringType::nonNullable()->coerceNamedValue('name', $fields);
    return $ret;
  }

  <<__Override>>
  public function coerceFieldNodes(
    dict<string, \Graphpinator\Parser\Value\Value> $fields,
    dict<string, mixed> $vars,
  ): this::THackType {
    $ret = shape();
    $ret['name'] = Types\StringType::nonNullable()->coerceNamedNode('name', $fields, $vars);
    return $ret;
  }

  <<__Override>>
  public function assertValidFieldValues(
    KeyedContainer<arraykey, mixed> $fields,
  ): this::THackType {
    $ret = shape();
    $ret['name'] = Types\StringType::nonNullable()->assertValidVariableValue($fields['name']);
    return $ret;
  }

  <<__Override>>
  protected function getInputValue(
    string $field_name,
  ): ?GraphQL\Introspection\__InputValue {
    switch ($field_name) {
      case 'name':
        return shape(
          'name' => 'name',
          'type' => Types\StringType::nonNullable(),
        );
      default:
        return null;
    }
  }
}
