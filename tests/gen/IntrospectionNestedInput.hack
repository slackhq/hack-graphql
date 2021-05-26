/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<c00cfa1740b3cf8339262d169497bf1e>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class IntrospectionNestedInput
  extends \Slack\GraphQL\Types\InputObjectType {

  const NAME = 'IntrospectionNestedInput';
  const type THackType = \TNestedInput;
  const keyset<string> FIELD_NAMES = keyset [
    'string',
    'vec_of_string',
  ];

  <<__Override>>
  public function coerceFieldValues(
    KeyedContainer<arraykey, mixed> $fields,
  ): this::THackType {
    $ret = shape();
    $ret['string'] = Types\StringType::nonNullable()->coerceNamedValue('string', $fields);
    $ret['vec_of_string'] = Types\StringType::nonNullable()->nonNullableInputListOf()->coerceNamedValue('vec_of_string', $fields);
    return $ret;
  }

  <<__Override>>
  public function coerceFieldNodes(
    dict<string, \Graphpinator\Parser\Value\Value> $fields,
    dict<string, mixed> $vars,
  ): this::THackType {
    $ret = shape();
    $ret['string'] = Types\StringType::nonNullable()->coerceNamedNode('string', $fields, $vars);
    $ret['vec_of_string'] = Types\StringType::nonNullable()->nonNullableInputListOf()->coerceNamedNode('vec_of_string', $fields, $vars);
    return $ret;
  }

  <<__Override>>
  public function assertValidFieldValues(
    KeyedContainer<arraykey, mixed> $fields,
  ): this::THackType {
    $ret = shape();
    $ret['string'] = Types\StringType::nonNullable()->assertValidVariableValue($fields['string']);
    $ret['vec_of_string'] = Types\StringType::nonNullable()->nonNullableInputListOf()->assertValidVariableValue($fields['vec_of_string']);
    return $ret;
  }

  <<__Override>>
  protected function getInputValue(
    string $field_name,
  ): ?GraphQL\Introspection\__InputValue {
    switch ($field_name) {
      case 'string':
        return shape(
          'name' => 'string',
          'type' => Types\StringType::nonNullable(),
        );
      case 'vec_of_string':
        return shape(
          'name' => 'vec_of_string',
          'type' => Types\StringType::nonNullable()->nonNullableInputListOf(),
        );
      default:
        return null;
    }
  }
}
