/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<a0f531af9fb4fb4b4de55baa03a2d7e3>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __InputValue extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__InputValue';
  const type THackType = \Slack\GraphQL\Introspection\__InputValue;
  const keyset<string> FIELD_NAMES = keyset[
    'name',
    'description',
    'type',
    'defaultValue',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): GraphQL\IFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getDescription(),
        );
      case 'type':
        return new GraphQL\FieldDefinition(
          'type',
          __Type::nullable(),
          async ($parent, $args, $vars) ==> $parent->getType(),
        );
      case 'defaultValue':
        return new GraphQL\FieldDefinition(
          'defaultValue',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getDefaultValue(),
        );
      default:
        throw new \Exception('Unknown field: '.$field_name);
    }
  }
}
