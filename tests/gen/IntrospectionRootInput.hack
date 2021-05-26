/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<24d6228313f9d2588f4243d7235b3b54>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class IntrospectionRootInput
  extends \Slack\GraphQL\Types\InputObjectType {

  const NAME = 'IntrospectionRootInput';
  const type THackType = \TRootInput;
  const keyset<string> FIELD_NAMES = keyset [
    'scalar',
    'nested',
    'vec_of_nested_non_nullable',
    'vec_of_nested_nullable',
    'non_nullable',
  ];

  <<__Override>>
  public function coerceFieldValues(
    KeyedContainer<arraykey, mixed> $fields,
  ): this::THackType {
    $ret = shape();
    if (C\contains_key($fields, 'scalar')) {
      $ret['scalar'] = Types\StringType::nullableInput()->coerceNamedValue('scalar', $fields);
    }
    if (C\contains_key($fields, 'nested')) {
      $ret['nested'] = IntrospectionNestedInput::nullableInput()->coerceNamedValue('nested', $fields);
    }
    if (C\contains_key($fields, 'vec_of_nested_non_nullable')) {
      $ret['vec_of_nested_non_nullable'] = IntrospectionNestedInput::nonNullable()->nullableInputListOf()->coerceNamedValue('vec_of_nested_non_nullable', $fields);
    }
    if (C\contains_key($fields, 'vec_of_nested_nullable')) {
      $ret['vec_of_nested_nullable'] = IntrospectionNestedInput::nullableInput()->nullableInputListOf()->coerceNamedValue('vec_of_nested_nullable', $fields);
    }
    $ret['non_nullable'] = Types\StringType::nonNullable()->coerceNamedValue('non_nullable', $fields);
    return $ret;
  }

  <<__Override>>
  public function coerceFieldNodes(
    dict<string, \Graphpinator\Parser\Value\Value> $fields,
    dict<string, mixed> $vars,
  ): this::THackType {
    $ret = shape();
    if ($this->hasValue('scalar', $fields, $vars)) {
      $ret['scalar'] = Types\StringType::nullableInput()->coerceNamedNode('scalar', $fields, $vars);
    }
    if ($this->hasValue('nested', $fields, $vars)) {
      $ret['nested'] = IntrospectionNestedInput::nullableInput()->coerceNamedNode('nested', $fields, $vars);
    }
    if ($this->hasValue('vec_of_nested_non_nullable', $fields, $vars)) {
      $ret['vec_of_nested_non_nullable'] = IntrospectionNestedInput::nonNullable()->nullableInputListOf()->coerceNamedNode('vec_of_nested_non_nullable', $fields, $vars);
    }
    if ($this->hasValue('vec_of_nested_nullable', $fields, $vars)) {
      $ret['vec_of_nested_nullable'] = IntrospectionNestedInput::nullableInput()->nullableInputListOf()->coerceNamedNode('vec_of_nested_nullable', $fields, $vars);
    }
    $ret['non_nullable'] = Types\StringType::nonNullable()->coerceNamedNode('non_nullable', $fields, $vars);
    return $ret;
  }

  <<__Override>>
  public function assertValidFieldValues(
    KeyedContainer<arraykey, mixed> $fields,
  ): this::THackType {
    $ret = shape();
    if (C\contains_key($fields, 'scalar')) {
      $ret['scalar'] = Types\StringType::nullableInput()->assertValidVariableValue($fields['scalar']);
    }
    if (C\contains_key($fields, 'nested')) {
      $ret['nested'] = IntrospectionNestedInput::nullableInput()->assertValidVariableValue($fields['nested']);
    }
    if (C\contains_key($fields, 'vec_of_nested_non_nullable')) {
      $ret['vec_of_nested_non_nullable'] = IntrospectionNestedInput::nonNullable()->nullableInputListOf()->assertValidVariableValue($fields['vec_of_nested_non_nullable']);
    }
    if (C\contains_key($fields, 'vec_of_nested_nullable')) {
      $ret['vec_of_nested_nullable'] = IntrospectionNestedInput::nullableInput()->nullableInputListOf()->assertValidVariableValue($fields['vec_of_nested_nullable']);
    }
    $ret['non_nullable'] = Types\StringType::nonNullable()->assertValidVariableValue($fields['non_nullable']);
    return $ret;
  }

  <<__Override>>
  protected function getInputValue(
    string $field_name,
  ): ?GraphQL\Introspection\__InputValue {
    switch ($field_name) {
      case 'scalar':
        return shape(
          'name' => 'scalar',
          'type' => Types\StringType::nullableInput(),
        );
      case 'nested':
        return shape(
          'name' => 'nested',
          'type' => IntrospectionNestedInput::nullableInput(),
        );
      case 'vec_of_nested_non_nullable':
        return shape(
          'name' => 'vec_of_nested_non_nullable',
          'type' => IntrospectionNestedInput::nonNullable()->nullableInputListOf(),
        );
      case 'vec_of_nested_nullable':
        return shape(
          'name' => 'vec_of_nested_nullable',
          'type' => IntrospectionNestedInput::nullableInput()->nullableInputListOf(),
        );
      case 'non_nullable':
        return shape(
          'name' => 'non_nullable',
          'type' => Types\StringType::nonNullable(),
        );
      default:
        return null;
    }
  }
}
