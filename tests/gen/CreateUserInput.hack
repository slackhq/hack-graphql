/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<6aeb569082bd4dddfb54528630c0c724>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class CreateUserInput extends \Slack\GraphQL\Types\InputObjectType {

  const NAME = 'CreateUserInput';
  const type THackType = \TCreateUserInput;
  const keyset<string> FIELD_NAMES = keyset [
    'name',
    'is_active',
    'team',
    'favorite_color',
  ];

  <<__Override>>
  public function getDescription(): ?string {
    return 'Arguments for creating a user';
  }

  <<__Override>>
  public function coerceFieldValues(
    KeyedContainer<arraykey, mixed> $fields,
  ): this::THackType {
    $ret = shape();
    $ret['name'] = Types\StringInputType::nonNullable()->coerceNamedValue('name', $fields);
    if (C\contains_key($fields, 'is_active')) {
      $ret['is_active'] = Types\BooleanInputType::nullable()->coerceNamedValue('is_active', $fields);
    }
    if (C\contains_key($fields, 'team')) {
      $ret['team'] = CreateTeamInput::nullable()->coerceNamedValue('team', $fields);
    }
    if (C\contains_key($fields, 'favorite_color')) {
      $ret['favorite_color'] = FavoriteColorInputType::nullable()->coerceNamedValue('favorite_color', $fields);
    }
    return $ret;
  }

  <<__Override>>
  public function coerceFieldNodes(
    dict<string, \Graphpinator\Parser\Value\Value> $fields,
    dict<string, mixed> $vars,
  ): this::THackType {
    $ret = shape();
    $ret['name'] = Types\StringInputType::nonNullable()->coerceNamedNode('name', $fields, $vars);
    if ($this->hasValue('is_active', $fields, $vars)) {
      $ret['is_active'] = Types\BooleanInputType::nullable()->coerceNamedNode('is_active', $fields, $vars);
    }
    if ($this->hasValue('team', $fields, $vars)) {
      $ret['team'] = CreateTeamInput::nullable()->coerceNamedNode('team', $fields, $vars);
    }
    if ($this->hasValue('favorite_color', $fields, $vars)) {
      $ret['favorite_color'] = FavoriteColorInputType::nullable()->coerceNamedNode('favorite_color', $fields, $vars);
    }
    return $ret;
  }
}
