/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<abe02c92a0514db7508f940558441b9e>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class InterfaceB extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'InterfaceB';
  const type THackType = \InterfaceB;

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'foo':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->foo(),
        );
      case 'bar':
        return new GraphQL\FieldDefinition(
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->bar(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}
