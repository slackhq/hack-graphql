/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<18929d891365b1f5f09d9b3f814b431c>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Concrete extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Concrete';
  const type THackType = \Concrete;
  const keyset<string> FIELD_NAMES = keyset[
    'bar',
    'baz',
    'foo',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'bar':
        return new GraphQL\FieldDefinition(
          'bar',
          Types\StringType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->bar(),
        );
      case 'baz':
        return new GraphQL\FieldDefinition(
          'baz',
          Types\StringType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->baz(),
        );
      case 'foo':
        return new GraphQL\FieldDefinition(
          'foo',
          Types\StringType::nullableOutput($this->schema),
          dict[],
          async ($parent, $args, $vars) ==> $parent->foo(),
        );
      default:
        return null;
    }
  }
}
