/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<94a6304776b008d796791c4b0798101c>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __InputValue extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__InputValue';
  const type THackType = \Slack\GraphQL\Introspection\__InputValue;
  const keyset<string> FIELD_NAMES = keyset[
    'defaultValue',
    'description',
    'name',
    'type',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'defaultValue':
        return new GraphQL\FieldDefinition(
          'defaultValue',
          Types\StringType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getDefaultValue(),
        );
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getDescription(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'type':
        return new GraphQL\FieldDefinition(
          'type',
          __Type::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getType(),
        );
      default:
        return null;
    }
  }
}
