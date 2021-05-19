/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<4bbcb2479d548616d1da3bfd00df91ff>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class OutputTypeTestObj extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'OutputTypeTestObj';
  const type THackType = \OutputTypeTestObj;
  const keyset<string> FIELD_NAMES = keyset[
    'awaitable',
    'awaitable_nullable',
    'awaitable_nullable_list',
    'list',
    'nested_lists',
    'nullable',
    'scalar',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'awaitable':
        return new GraphQL\FieldDefinition(
          'awaitable',
          Types\IntOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->awaitable(),
        );
      case 'awaitable_nullable':
        return new GraphQL\FieldDefinition(
          'awaitable_nullable',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->awaitable_nullable(),
        );
      case 'awaitable_nullable_list':
        return new GraphQL\FieldDefinition(
          'awaitable_nullable_list',
          Types\IntOutputType::nonNullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> await $parent->awaitable_nullable_list(),
        );
      case 'list':
        return new GraphQL\FieldDefinition(
          'list',
          Types\StringOutputType::nonNullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->list(),
        );
      case 'nested_lists':
        return new GraphQL\FieldDefinition(
          'nested_lists',
          Types\IntOutputType::nullable()->nonNullableListOf()->nullableListOf()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested_lists(),
        );
      case 'nullable':
        return new GraphQL\FieldDefinition(
          'nullable',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nullable(),
        );
      case 'scalar':
        return new GraphQL\FieldDefinition(
          'scalar',
          Types\IntOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->scalar(),
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
      'description' => 'Test object for fields with various return types',
      'fields' => vec[
        shape(
          'name' => 'awaitable',
          'description' => '',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'awaitable_nullable',
          'description' => '',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'awaitable_nullable_list',
          'description' => '',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int'))->nonNullable()->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'list',
          'description' => '',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String'))->nonNullable()->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'nested_lists',
          'description' => 'Note that nested lists can be non-nullable',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int'))->nonNullableListOf()->nullableListOf()->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'nullable',
          'description' => '',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'scalar',
          'description' => 'Note that the GraphQL field will be nullable by default, despite its non-nullable Hack type',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
      ],
    ));
  }
}
