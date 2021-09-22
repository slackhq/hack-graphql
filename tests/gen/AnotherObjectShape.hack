/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<25f33679953f3c7f20136a2eebb74fd0>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class AnotherObjectShape extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'AnotherObjectShape';
  const type THackType = \AnotherObjectShape;
  const keyset<string> FIELD_NAMES = keyset[
    'abc',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'abc':
        return new GraphQL\FieldDefinition(
          'abc',
          Types\IntType::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['abc'],
          null,
          false,
          null,
        );
      default:
        return null;
    }
  }
}
