/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<3b3c4778e755e10ca88aaae61ea8ec2d>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __EnumValue extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__EnumValue';
  const type THackType = \Slack\GraphQL\Introspection\__EnumValue;
  const keyset<string> FIELD_NAMES = keyset[
    'name',
    'description',
    'isDeprecated',
    'deprecationReason',
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
      case 'isDeprecated':
        return new GraphQL\FieldDefinition(
          'isDeprecated',
          Types\BooleanOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['isDeprecated'],
        );
      case 'deprecationReason':
        return new GraphQL\FieldDefinition(
          'deprecationReason',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['deprecationReason'] ?? null,
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
          'name' => 'isDeprecated',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Boolean'))->nonNullable(),
          'args' => vec[],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'deprecationReason',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String'))->nonNullable(),
          'args' => vec[],
          'isDeprecated' => false,
        ),
      ],
    ));
  }
}
