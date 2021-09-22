/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<796f38c47585b4bd8216598885e63d20>>
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
          null,
          null,
        );
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringType::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['description'],
          null,
          null,
        );
      case 'locations':
        return new GraphQL\FieldDefinition(
          'locations',
          Types\StringType::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['locations'],
          null,
          null,
        );
      case 'args':
        return new GraphQL\FieldDefinition(
          'args',
          __InputValue::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['args'],
          null,
          null,
        );
      default:
        return null;
    }
  }
}
