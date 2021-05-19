/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<479df249ecefc0a7625fddf81e9917e0>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __Type extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__Type';
  const type THackType = \Slack\GraphQL\Introspection\__Type;
  const keyset<string> FIELD_NAMES = keyset[
    'description',
    'enumValues',
    'fields',
    'inputFields',
    'interfaces',
    'kind',
    'name',
    'ofType',
    'possibleTypes',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getDescription(),
        );
      case 'enumValues':
        return new GraphQL\FieldDefinition(
          'enumValues',
          __EnumValue::nonNullable()->nullableListOf(),
          dict[
            'include_deprecated' => shape(
              'name' => 'include_deprecated',
              'type' => Types\BooleanInputType::nonNullable(),
              'default_value' => false,
            ),
          ],
          async ($parent, $args, $vars) ==> $parent->getEnumValues(
            Types\BooleanInputType::nonNullable()->coerceOptionalNamedNode('include_deprecated', $args, $vars, false),
          ),
        );
      case 'fields':
        return new GraphQL\FieldDefinition(
          'fields',
          __Field::nonNullable()->nullableListOf(),
          dict[
            'include_deprecated' => shape(
              'name' => 'include_deprecated',
              'type' => Types\BooleanInputType::nonNullable(),
              'default_value' => false,
            ),
          ],
          async ($parent, $args, $vars) ==> $parent->getFields(
            Types\BooleanInputType::nonNullable()->coerceOptionalNamedNode('include_deprecated', $args, $vars, false),
          ),
        );
      case 'inputFields':
        return new GraphQL\FieldDefinition(
          'inputFields',
          __InputValue::nonNullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getInputFields(),
        );
      case 'interfaces':
        return new GraphQL\FieldDefinition(
          'interfaces',
          __Type::nonNullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getInterfaces(),
        );
      case 'kind':
        return new GraphQL\FieldDefinition(
          'kind',
          __TypeKindOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getKind(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'ofType':
        return new GraphQL\FieldDefinition(
          'ofType',
          __Type::nullable(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getOfType(),
        );
      case 'possibleTypes':
        return new GraphQL\FieldDefinition(
          'possibleTypes',
          __Type::nonNullable()->nullableListOf(),
          dict[],
          async ($parent, $args, $vars) ==> $parent->getPossibleTypes(),
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
      'description' => 'Type introspection',
      'fields' => vec[
        shape(
          'name' => 'description',
          'description' => 'Description of the type',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'enumValues',
          'description' => 'Enum values, only applies to ENUM',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, '__EnumValue'))->nonNullable()->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'fields',
          'description' => 'Fields of the type, only applies to OBJECT and INTERFACE',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, '__Field'))->nonNullable()->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'inputFields',
          'description' => 'Input fields, only applies to INPUT_OBJECT',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, '__InputValue'))->nonNullable()->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'interfaces',
          'description' => 'Interfaces the object implements, only applies to OBJECT',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, '__Type'))->nonNullable()->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'kind',
          'description' => 'Kind of the type',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, '__TypeKindOutputType')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'name',
          'description' => 'Name of the type',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, 'String')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'ofType',
          'description' => 'Underlying wrapped type, only applies to NON_NULL and LIST',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, '__Type')),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
        shape(
          'name' => 'possibleTypes',
          'description' => 'Possible types that implement this interface, only applies to INTERFACE',
          'type' => (new GraphQL\Introspection\NamedTypeReference($schema, '__Type'))->nonNullable()->nullableListOf(),
          'args' => vec[
          ],
          'isDeprecated' => false,
        ),
      ],
    ));
  }
}
