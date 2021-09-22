/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<e82a61f3c460022ae085ff1c35d30707>>
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
          'Directives supported by the schema',
          false,
          null,
        );
      case 'mutationType':
        return new GraphQL\FieldDefinition(
          'mutationType',
          __Type::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionMutationType(),
          'Mutation root type',
          false,
          null,
        );
      case 'queryType':
        return new GraphQL\FieldDefinition(
          'queryType',
          __Type::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionQueryType(),
          'Query root type',
          false,
          null,
        );
      case 'subscriptionType':
        return new GraphQL\FieldDefinition(
          'subscriptionType',
          __Type::nullableOutput(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionSubscriptionType(),
          'Subscription root type',
          false,
          null,
        );
      case 'types':
        return new GraphQL\FieldDefinition(
          'types',
          __Type::nonNullable()->nullableOutputListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getTypes(),
          'Types contained within the schema',
          false,
          null,
        );
      default:
        return null;
    }
  }
}
