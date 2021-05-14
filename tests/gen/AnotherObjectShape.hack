/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<2ff929146421fb59c0c6389503cfa492>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class AnotherObjectShape extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'AnotherObjectShape';
  const type THackType = \AnotherObjectShape;

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'abc':
        return new GraphQL\FieldDefinition(
          Types\IntOutputType::nonNullable()->nullableListOf(),
          async ($parent, $args, $vars) ==> $parent['abc'],
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}
