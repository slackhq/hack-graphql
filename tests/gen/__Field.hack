/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<73693b44bf2e80a46d77ba16562dc5b2>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __Field extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__Field';
  const type THackType = \Slack\GraphQL\Introspection\__Field;
  const keyset<string> FIELD_NAMES = keyset[
    'name',
    'type',
  ];

  <<__Override>>
  public function getDescription(): ?string {
    return 'Field introspection';
  }

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'type':
        return new GraphQL\FieldDefinition(
          'type',
          __Type::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionType(),
        );
      default:
        return null;
    }
  }
}
