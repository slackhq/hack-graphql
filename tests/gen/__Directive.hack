/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<b1d8eb76c718408ebf7c0b3cb1eddeab>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __Directive extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__Directive';
  const type THackType = \Slack\GraphQL\Introspection\__Directive;
  const keyset<string> FIELD_NAMES = keyset[
    'name',
    'description',
    'locations',
    'args',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['name'],
          vec[],
        );
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['description'],
          vec[],
        );
      case 'locations':
        return new GraphQL\FieldDefinition(
          'locations',
          Types\StringType::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['locations'],
          vec[],
        );
      case 'args':
        return new GraphQL\FieldDefinition(
          'args',
          __InputValue::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['args'],
          vec[],
        );
      default:
        return null;
    }
  }
}
