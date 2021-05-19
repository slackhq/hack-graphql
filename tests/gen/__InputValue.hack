/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<00b9edbdb83f80ad91d702508f49ef95>>
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
      case 'type':
        return new GraphQL\FieldDefinition(
          'type',
          __Type::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['type'],
        );
      case 'defaultValue':
        return new GraphQL\FieldDefinition(
          'defaultValue',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['defaultValue'] ?? null,
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
          'name' => 'type',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, '__Type'))->nonNullable(),
          'args' => vec[],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'defaultValue',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String'))->nonNullable(),
          'args' => vec[],
          'isDeprecated' => false,
        ),
      ],
    ));
  }
}
