/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<46d4dec65d0766132a20c78462269f27>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __Directive extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__Directive';
  const type THackType = \Slack\GraphQL\Introspection\__Directive;
  const keyset<string> FIELD_NAMES = keyset[
    'name',
    'description',
    'locations',
    'args',
    'isRepeatable',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['name'],
        );
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['description'] ?? null,
        );
      case 'locations':
        return new GraphQL\FieldDefinition(
          'locations',
          __DirectiveLocationOutputType::nonNullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['locations'],
        );
      case 'args':
        return new GraphQL\FieldDefinition(
          'args',
          __InputValue::nonNullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['args'],
        );
      case 'isRepeatable':
        return new GraphQL\FieldDefinition(
          'isRepeatable',
          Types\BooleanOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['isRepeatable'],
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
      'description' => '',
      'fields' => vec[
        shape(
          'name' => 'name',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String'))->nonNullable(),
          'args' => vec[],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'description',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String'))->nonNullable(),
          'args' => vec[],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'locations',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, '__DirectiveLocationOutputType'))->nonNullable()->nonNullableListOf(),
          'args' => vec[],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'args',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, '__InputValue'))->nonNullable()->nonNullableListOf(),
          'args' => vec[],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'isRepeatable',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Boolean'))->nonNullable(),
          'args' => vec[],
          'isDeprecated' => false,
        ),
      ],
    ));
  }
}
