/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<5e9816ae88463151bbbadeb9b46700a7>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class NestedOutputShape extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'NestedOutputShape';
  const type THackType = \TOutputNestedShape;
  const keyset<string> FIELD_NAMES = keyset[
    'vec_of_string',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'vec_of_string':
        return new GraphQL\FieldDefinition(
          'vec_of_string',
          Types\StringType::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['vec_of_string'],
        );
      default:
        return null;
    }
  }
}
