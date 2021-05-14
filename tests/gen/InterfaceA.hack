/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<b6548416951c86d1397e7ae7f8af2c14>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class InterfaceA extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'InterfaceA';
  const type THackType = \InterfaceA;

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
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
