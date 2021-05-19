/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<d568e6ce0f742747bbcf1e6bbdf47554>>
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

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'abc':
        return new GraphQL\FieldDefinition(
          'abc',
          Types\IntOutputType::nonNullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent['abc'],
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
      'description' => 'AnotherObjectShape',
      'fields' => vec[
        shape(
          'name' => 'abc',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int'))->nonNullable()->nonNullableListOf(),
          'args' => vec[],
          'isDeprecated' => false,
        ),
      ],
    ));
  }
}
