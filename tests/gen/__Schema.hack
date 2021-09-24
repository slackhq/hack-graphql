/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<3a2ace1dfaf20502d018e61b7180b689>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __Schema extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__Schema';
  const type THackType = \Slack\GraphQL\Introspection\__Schema;
  const keyset<string> FIELD_NAMES = keyset[
    'directives',
    'mutationType',
    'queryType',
    'subscriptionType',
    'types',
  ];
  const dict<string, classname<Types\InterfaceType>> INTERFACES = dict[
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'directives':
        return new GraphQL\FieldDefinition(
          'directives',
          __Directive::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getDirectives(),
          vec[],
        );
      case 'mutationType':
        return new GraphQL\FieldDefinition(
          'mutationType',
          __Type::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionMutationType(),
          vec[],
        );
      case 'queryType':
        return new GraphQL\FieldDefinition(
          'queryType',
          __Type::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionQueryType(),
          vec[],
        );
      case 'subscriptionType':
        return new GraphQL\FieldDefinition(
          'subscriptionType',
          __Type::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionSubscriptionType(),
          vec[],
        );
      case 'types':
        return new GraphQL\FieldDefinition(
          'types',
          __Type::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getTypes(),
          vec[],
        );
      default:
        return null;
    }
  }
}
