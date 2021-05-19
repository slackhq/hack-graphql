/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<222a0cc3760dc8aad97d37086c2c8ba3>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __Schema extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__Schema';
  const type THackType = \Slack\GraphQL\Introspection\__Schema;
  const keyset<string> FIELD_NAMES = keyset[
    'mutationType',
    'queryType',
    'types',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'mutationType':
        return new GraphQL\FieldDefinition(
          'mutationType',
          __Type::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionMutationType(),
        );
      case 'queryType':
        return new GraphQL\FieldDefinition(
          'queryType',
          __Type::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionQueryType(),
        );
      case 'types':
        return new GraphQL\FieldDefinition(
          'types',
          __Type::nonNullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getIntrospectionTypes(),
        );
      default:
        return null;
    }
  }

  public static function introspect(
    GraphQL\Introspection\__Schema $schema,
  ): GraphQL\Introspection\NamedTypeDeclaration {
    return new GraphQL\Introspection\NamedTypeDeclaration(shape(
      'kind' => GraphQL\Introspection\__TypeKind::OBJECT,
      'name' => static::NAME,
      'description' => 'Schema introspection',
      'fields' => vec[
        shape(
          'name' => 'mutationType',
          'description' => 'Mutation root type',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, '__Type')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'queryType',
          'description' => 'Query root type',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, '__Type')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'types',
          'description' => 'Types contained within the schema',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, '__Type'))->nonNullable()->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
      ],
    ));
  }
}
