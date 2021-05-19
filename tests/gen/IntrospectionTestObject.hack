/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<0f9b2792478a460c14a99f0ef4f4976d>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class IntrospectionTestObject extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'IntrospectionTestObject';
  const type THackType = \IntrospectionTestObject;
  const keyset<string> FIELD_NAMES = keyset[
    'default_list_of_non_nullable_int',
    'default_list_of_nullable_int',
    'default_nullable_string',
    'non_null_int',
    'non_null_list_of_non_null',
    'non_null_string',
    'nullable_string',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'default_list_of_non_nullable_int':
        return new GraphQL\FieldDefinition(
          'default_list_of_non_nullable_int',
          Types\IntOutputType::nonNullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getDefaultListOfNonNullableInt(),
        );
      case 'default_list_of_nullable_int':
        return new GraphQL\FieldDefinition(
          'default_list_of_nullable_int',
          Types\IntOutputType::nullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getDefaultListOfNullableInt(),
        );
      case 'default_nullable_string':
        return new GraphQL\FieldDefinition(
          'default_nullable_string',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getDefaultNullableString(),
        );
      case 'non_null_int':
        return new GraphQL\FieldDefinition(
          'non_null_int',
          Types\IntOutputType::nonNullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getNonNullInt(),
        );
      case 'non_null_list_of_non_null':
        return new GraphQL\FieldDefinition(
          'non_null_list_of_non_null',
          Types\IntOutputType::nonNullable()->nonNullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getNonNullListOfNonNull(),
        );
      case 'non_null_string':
        return new GraphQL\FieldDefinition(
          'non_null_string',
          Types\StringOutputType::nonNullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getNonNullString(),
        );
      case 'nullable_string':
        return new GraphQL\FieldDefinition(
          'nullable_string',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getNullableString(),
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
      'description' => 'Test object for introspection',
      'fields' => vec[
        shape(
          'name' => 'default_list_of_non_nullable_int',
          'description' => 'Default list of non nullable int',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int'))->nonNullable()->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'default_list_of_nullable_int',
          'description' => 'Default list of nullable int',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int'))->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'default_nullable_string',
          'description' => 'Default nullable string',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'non_null_int',
          'description' => 'Nullable string',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int'))->nonNullable(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'non_null_list_of_non_null',
          'description' => 'Non nullable list of non nullables',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int'))->nonNullable()->nonNullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'non_null_string',
          'description' => 'Non nullable string',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String'))->nonNullable(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'nullable_string',
          'description' => 'Nullable string',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
      ],
    ));
  }
}
