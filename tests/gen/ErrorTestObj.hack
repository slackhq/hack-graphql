/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<32a074378d5b7449d2db26687ca38467>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class ErrorTestObj extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'ErrorTestObj';
  const type THackType = \ErrorTestObj;
  const keyset<string> FIELD_NAMES = keyset[
    'bad_int_list_n_of_n',
    'bad_int_list_n_of_nn',
    'bad_int_list_nn_of_nn',
    'hidden_exception',
    'nested',
    'nested_list_n_of_n',
    'nested_list_n_of_nn',
    'nested_list_nn_of_nn',
    'nested_nn',
    'no_error',
    'non_nullable',
    'user_facing_error',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'bad_int_list_n_of_n':
        return new GraphQL\FieldDefinition(
          'bad_int_list_n_of_n',
          Types\IntOutputType::nullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->bad_int_list_n_of_n(),
        );
      case 'bad_int_list_n_of_nn':
        return new GraphQL\FieldDefinition(
          'bad_int_list_n_of_nn',
          Types\IntOutputType::nonNullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->bad_int_list_n_of_nn(),
        );
      case 'bad_int_list_nn_of_nn':
        return new GraphQL\FieldDefinition(
          'bad_int_list_nn_of_nn',
          Types\IntOutputType::nonNullable()->nonNullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->bad_int_list_nn_of_nn(),
        );
      case 'hidden_exception':
        return new GraphQL\FieldDefinition(
          'hidden_exception',
          Types\IntOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->hidden_exception(),
        );
      case 'nested':
        return new GraphQL\FieldDefinition(
          'nested',
          ErrorTestObj::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested(),
        );
      case 'nested_list_n_of_n':
        return new GraphQL\FieldDefinition(
          'nested_list_n_of_n',
          ErrorTestObj::nullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested_list_n_of_n(),
        );
      case 'nested_list_n_of_nn':
        return new GraphQL\FieldDefinition(
          'nested_list_n_of_nn',
          ErrorTestObj::nonNullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested_list_n_of_nn(),
        );
      case 'nested_list_nn_of_nn':
        return new GraphQL\FieldDefinition(
          'nested_list_nn_of_nn',
          ErrorTestObj::nonNullable()->nonNullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested_list_nn_of_nn(),
        );
      case 'nested_nn':
        return new GraphQL\FieldDefinition(
          'nested_nn',
          ErrorTestObj::nonNullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->nested_nn(),
        );
      case 'no_error':
        return new GraphQL\FieldDefinition(
          'no_error',
          Types\IntOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->no_error(),
        );
      case 'non_nullable':
        return new GraphQL\FieldDefinition(
          'non_nullable',
          Types\IntOutputType::nonNullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->non_nullable(),
        );
      case 'user_facing_error':
        return new GraphQL\FieldDefinition(
          'user_facing_error',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->user_facing_error(),
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
      'description' => 'Test object for error handling',
      'fields' => vec[
        shape(
          'name' => 'bad_int_list_n_of_n',
          'description' => '',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int'))->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'bad_int_list_n_of_nn',
          'description' => 'Nullability of nested types is respected, which may result in killing the whole list (but no parents)',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int'))->nonNullable()->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'bad_int_list_nn_of_nn',
          'description' => '',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int'))->nonNullable()->nonNullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'hidden_exception',
          'description' => 'Arbitrary exceptions are hidden from clients, since they might contain sensitive data',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'nested',
          'description' => '',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'ErrorTestObj')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'nested_list_n_of_n',
          'description' => '',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'ErrorTestObj'))->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'nested_list_n_of_nn',
          'description' => '',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'ErrorTestObj'))->nonNullable()->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'nested_list_nn_of_nn',
          'description' => '',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'ErrorTestObj'))->nonNullable()->nonNullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'nested_nn',
          'description' => '',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'ErrorTestObj'))->nonNullable(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'no_error',
          'description' => '',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'non_nullable',
          'description' => '',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int'))->nonNullable(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'user_facing_error',
          'description' => '',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
      ],
    ));
  }
}
