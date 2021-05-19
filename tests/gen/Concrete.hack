/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<8642a922087f4da5a085314a898b5a57>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Concrete extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Concrete';
  const type THackType = \Concrete;
  const keyset<string> FIELD_NAMES = keyset[
    'bar',
    'baz',
    'foo',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'bar':
        return new GraphQL\FieldDefinition(
          'bar',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->bar(),
        );
      case 'baz':
        return new GraphQL\FieldDefinition(
          'baz',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->baz(),
        );
      case 'foo':
        return new GraphQL\FieldDefinition(
          'foo',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->foo(),
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
      'description' => 'Concrete',
      'fields' => vec[
        shape(
          'name' => 'bar',
          'description' => 'bar',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'baz',
          'description' => 'baz',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'foo',
          'description' => 'foo',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
      ],
    ));
  }
}
