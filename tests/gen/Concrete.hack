/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<f12e35f792172c548c0569963a236274>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Concrete extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Concrete';
  const type THackType = \Concrete;

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'bar':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->bar(),
        );
      case 'baz':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->baz(),
        );
      case 'foo':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->foo(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}
