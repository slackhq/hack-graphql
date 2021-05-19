/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<5d674561a2e1089caeb78cbabdd3fa5f>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class ObjectShape extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'ObjectShape';
  const type THackType = \ObjectShape;
  const keyset<string> FIELD_NAMES = keyset[
    'foo',
    'bar',
    'baz',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'foo':
        return new GraphQL\FieldDefinition(
          'foo',
          Types\IntOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['foo'],
        );
      case 'bar':
        return new GraphQL\FieldDefinition(
          'bar',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['bar'] ?? null,
        );
      case 'baz':
        return new GraphQL\FieldDefinition(
          'baz',
          AnotherObjectShape::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['baz'],
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
      'description' => 'ObjectShape',
      'fields' => vec[
        shape(
          'name' => 'foo',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int'))->nonNullable(),
          'args' => vec[],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'bar',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String'))->nonNullable(),
          'args' => vec[],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'baz',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'AnotherObjectShape'))->nonNullable(),
          'args' => vec[],
          'isDeprecated' => false,
        ),
      ],
    ));
  }
}
