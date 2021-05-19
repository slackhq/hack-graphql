/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<1e4281f1a60ebaac15c9e332051652de>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Schema extends \Slack\GraphQL\BaseSchema {

  const dict<string, classname<Types\NamedInputType>> INPUT_TYPES = dict[
    'Boolean' => Types\BooleanInputType::class,
    'CreateTeamInput' => CreateTeamInput::class,
    'CreateUserInput' => CreateUserInput::class,
    'FavoriteColor' => FavoriteColorInputType::class,
    'Int' => Types\IntInputType::class,
    'String' => Types\StringInputType::class,
    '__DirectiveLocation' => __DirectiveLocationInputType::class,
    '__TypeKind' => __TypeKindInputType::class,
  ];
  const dict<string, classname<Types\NamedOutputType>> OUTPUT_TYPES = dict[
    'AnotherObjectShape' => AnotherObjectShape::class,
    'Boolean' => Types\BooleanOutputType::class,
    'Bot' => Bot::class,
    'Concrete' => Concrete::class,
    'ErrorTestObj' => ErrorTestObj::class,
    'FavoriteColor' => FavoriteColorOutputType::class,
    'Human' => Human::class,
    'Int' => Types\IntOutputType::class,
    'InterfaceA' => InterfaceA::class,
    'InterfaceB' => InterfaceB::class,
    'IntrospectionTestObject' => IntrospectionTestObject::class,
    'Mutation' => Mutation::class,
    'ObjectShape' => ObjectShape::class,
    'OutputTypeTestObj' => OutputTypeTestObj::class,
    'Query' => Query::class,
    'String' => Types\StringOutputType::class,
    'Team' => Team::class,
    'User' => User::class,
    '__Directive' => __Directive::class,
    '__DirectiveLocation' => __DirectiveLocationOutputType::class,
    '__EnumValue' => __EnumValue::class,
    '__Field' => __Field::class,
    '__InputValue' => __InputValue::class,
    '__Schema' => __Schema::class,
    '__Type' => __Type::class,
    '__TypeKind' => __TypeKindOutputType::class,
  ];
  const classname<\Slack\GraphQL\Types\ObjectType> QUERY_TYPE = Query::class;
  const classname<\Slack\GraphQL\Types\ObjectType> MUTATION_TYPE = Mutation::class;

  public static async function resolveQuery(
    \Graphpinator\Parser\Operation\Operation $operation,
    \Slack\GraphQL\Variables $variables,
  ): Awaitable<GraphQL\ValidFieldResult<?dict<string, mixed>>> {
    return await Query::nullable()->resolveAsync(new GraphQL\Root(), $operation, $variables);
  }

  public static async function resolveMutation(
    \Graphpinator\Parser\Operation\Operation $operation,
    \Slack\GraphQL\Variables $variables,
  ): Awaitable<GraphQL\ValidFieldResult<?dict<string, mixed>>> {
    return await Mutation::nullable()->resolveAsync(new GraphQL\Root(), $operation, $variables);
  }
}
