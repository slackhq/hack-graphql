/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<135c709f956a27912c76f53d7216ef50>>
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
    $ret['name'] = Types\StringInputType::nonNullable()->coerceNamedValue('name', $fields);
    return $ret;
  }

  <<__Override>>
  public function coerceFieldNodes(
    dict<string, \Graphpinator\Parser\Value\Value> $fields,
    dict<string, mixed> $vars,
  ): this::THackType {
    $ret = shape();
    $ret['name'] = Types\StringInputType::nonNullable()->coerceNamedNode('name', $fields, $vars);
    return $ret;
  }
}
