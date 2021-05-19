/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<ff7f7618f537dcac539499dba3405c54>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Query extends \Slack\GraphQL\Types\ObjectType {

  const NAME = 'Query';
  const type THackType = \Slack\GraphQL\Root;
  const keyset<string> FIELD_NAMES = keyset[
    '__schema',
    '__type',
    'arg_test',
    'bot',
    'error_test',
    'error_test_nn',
    'getConcrete',
    'getInterfaceA',
    'getInterfaceB',
    'getObjectShape',
    'human',
    'introspection_test',
    'list_arg_test',
    'nested_list_sum',
    'optional_field_test',
    'output_type_test',
    'takes_favorite_color',
    'user',
    'viewer',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case '__schema':
        return new GraphQL\FieldDefinition(
          '__schema',
          __Schema::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> \Slack\GraphQL\Introspection\QueryRootFields::getSchema(),
        );
      case '__type':
        return new GraphQL\FieldDefinition(
          '__type',
          __Type::nullable(),
          dict[
            'name' => shape(
              'name' => 'name',
              'type' => Types\StringInputType::nonNullable(),
            ),
          ],
          async ($parent, $args, $vars) ==> \Slack\GraphQL\Introspection\QueryRootFields::getType(
            Types\StringInputType::nonNullable()->coerceNamedNode('name', $args, $vars),
          ),
        );
      case 'arg_test':
        return new GraphQL\FieldDefinition(
          'arg_test',
          Types\IntOutputType::nullable()->nullableListOf(),
          dict[
            'required' => shape(
              'name' => 'required',
              'type' => Types\IntInputType::nonNullable(),
            ),
            'nullable' => shape(
              'name' => 'nullable',
              'type' => Types\IntInputType::nullable(),
            ),
            'optional' => shape(
              'name' => 'optional',
              'type' => Types\IntInputType::nullable(),
              'default_value' => 42,
            ),
          ],
          async ($parent, $args, $vars) ==> \ArgumentTestObj::argTest(
            Types\IntInputType::nonNullable()->coerceNamedNode('required', $args, $vars),
            Types\IntInputType::nullable()->coerceNamedNode('nullable', $args, $vars),
            Types\IntInputType::nullable()->coerceOptionalNamedNode('optional', $args, $vars, 42),
          ),
        );
      case 'bot':
        return new GraphQL\FieldDefinition(
          'bot',
          Bot::nullable(),
          dict[
            'id' => shape(
              'name' => 'id',
              'type' => Types\IntInputType::nonNullable(),
            ),
          ],
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getBot(
            Types\IntInputType::nonNullable()->coerceNamedNode('id', $args, $vars),
          ),
        );
      case 'error_test':
        return new GraphQL\FieldDefinition(
          'error_test',
          ErrorTestObj::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> \ErrorTestObj::get(),
        );
      case 'error_test_nn':
        return new GraphQL\FieldDefinition(
          'error_test_nn',
          ErrorTestObj::nonNullable(),
          dict[],
          async ($parent, $args, $vars) ==> \ErrorTestObj::getNonNullable(),
        );
      case 'getConcrete':
        return new GraphQL\FieldDefinition(
          'getConcrete',
          Concrete::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> \Concrete::getConcrete(),
        );
      case 'getInterfaceA':
        return new GraphQL\FieldDefinition(
          'getInterfaceA',
          InterfaceA::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> \Concrete::getInterfaceA(),
        );
      case 'getInterfaceB':
        return new GraphQL\FieldDefinition(
          'getInterfaceB',
          InterfaceB::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> \Concrete::getInterfaceB(),
        );
      case 'getObjectShape':
        return new GraphQL\FieldDefinition(
          'getObjectShape',
          ObjectShape::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> \ObjectTypeTestEntrypoint::getObjectShape(),
        );
      case 'human':
        return new GraphQL\FieldDefinition(
          'human',
          Human::nullable(),
          dict[
            'id' => shape(
              'name' => 'id',
              'type' => Types\IntInputType::nonNullable(),
            ),
          ],
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getHuman(
            Types\IntInputType::nonNullable()->coerceNamedNode('id', $args, $vars),
          ),
        );
      case 'introspection_test':
        return new GraphQL\FieldDefinition(
          'introspection_test',
          IntrospectionTestObject::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> \IntrospectionTestObject::get(),
        );
      case 'list_arg_test':
        return new GraphQL\FieldDefinition(
          'list_arg_test',
          Types\IntOutputType::nonNullable()->nullableListOf()->nullableListOf()->nullableListOf(),
          dict[
            'arg' => shape(
              'name' => 'arg',
              'type' => Types\IntInputType::nonNullable()->nullableListOf()->nonNullableListOf()->nullableListOf(),
            ),
          ],
          async ($parent, $args, $vars) ==> \ArgumentTestObj::listArgTest(
            Types\IntInputType::nonNullable()->nullableListOf()->nonNullableListOf()->nullableListOf()->coerceNamedNode('arg', $args, $vars),
          ),
        );
      case 'nested_list_sum':
        return new GraphQL\FieldDefinition(
          'nested_list_sum',
          Types\IntOutputType::nullable(),
          dict[
            'numbers' => shape(
              'name' => 'numbers',
              'type' => Types\IntInputType::nonNullable()->nonNullableListOf()->nonNullableListOf(),
            ),
          ],
          async ($parent, $args, $vars) ==> \UserQueryAttributes::getNestedListSum(
            Types\IntInputType::nonNullable()->nonNullableListOf()->nonNullableListOf()->coerceNamedNode('numbers', $args, $vars),
          ),
        );
      case 'optional_field_test':
        return new GraphQL\FieldDefinition(
          'optional_field_test',
          Types\StringOutputType::nullable(),
          dict[
            'input' => shape(
              'name' => 'input',
              'type' => CreateUserInput::nonNullable(),
            ),
          ],
          async ($parent, $args, $vars) ==> \UserQueryAttributes::optionalFieldTest(
            CreateUserInput::nonNullable()->coerceNamedNode('input', $args, $vars),
          ),
        );
      case 'output_type_test':
        return new GraphQL\FieldDefinition(
          'output_type_test',
          OutputTypeTestObj::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> \OutputTypeTestObj::get(),
        );
      case 'takes_favorite_color':
        return new GraphQL\FieldDefinition(
          'takes_favorite_color',
          Types\BooleanOutputType::nullable(),
          dict[
            'favorite_color' => shape(
              'name' => 'favorite_color',
              'type' => FavoriteColorInputType::nonNullable(),
            ),
          ],
          async ($parent, $args, $vars) ==> \UserQueryAttributes::takesFavoriteColor(
            FavoriteColorInputType::nonNullable()->coerceNamedNode('favorite_color', $args, $vars),
          ),
        );
      case 'user':
        return new GraphQL\FieldDefinition(
          'user',
          User::nullable(),
          dict[
            'id' => shape(
              'name' => 'id',
              'type' => Types\IntInputType::nonNullable(),
            ),
          ],
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getUser(
            Types\IntInputType::nonNullable()->coerceNamedNode('id', $args, $vars),
          ),
        );
      case 'viewer':
        return new GraphQL\FieldDefinition(
          'viewer',
          User::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> await \UserQueryAttributes::getViewer(),
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
      'description' => 'Query',
      'fields' => vec[
        shape(
          'name' => '__schema',
          'description' => 'Schema introspection',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, '__Schema')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => '__type',
          'description' => 'Type introspection',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, '__Type')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'arg_test',
          'description' => 'Root field for testing arguments',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int'))->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'bot',
          'description' => 'Fetch a bot by ID',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Bot')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'error_test',
          'description' => 'Root field to get an instance',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'ErrorTestObj')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'error_test_nn',
          'description' => 'A non-nullable root field to get an instance',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'ErrorTestObj'))->nonNullable(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'getConcrete',
          'description' => 'Root field to get an instance of Concrete',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Concrete')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'getInterfaceA',
          'description' => 'Root field to get an instance of InterfaceA',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'InterfaceA')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'getInterfaceB',
          'description' => 'Root field to get an instance of InterfaceB',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'InterfaceB')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'getObjectShape',
          'description' => 'fetch an object shape',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'ObjectShape')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'human',
          'description' => 'Fetch a user by ID',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Human')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'introspection_test',
          'description' => 'Root field to get an instance',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'IntrospectionTestObject')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'list_arg_test',
          'description' => 'Root field for testing list arguments',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int'))->nonNullable()->nullableListOf()->nullableListOf()->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'nested_list_sum',
          'description' => 'Test for nested list arguments',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Int')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'optional_field_test',
          'description' => 'Test for an optional input object field',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'output_type_test',
          'description' => 'Root field to get an instance',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'OutputTypeTestObj')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'takes_favorite_color',
          'description' => 'Test for enum arguments',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'Boolean')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'user',
          'description' => 'Fetch a user by ID',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'User')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'viewer',
          'description' => 'Authenticated viewer',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'User')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
      ],
    ));
  }
}
