/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<05fae459830946726df81669ba23886d>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class Schema extends \Slack\GraphQL\BaseSchema {

  const dict<string, classname<Types\NamedType>> TYPES = dict[
    'AnotherObjectShape' => AnotherObjectShape::class,
    'Boolean' => Types\BooleanType::class,
    'Bot' => Bot::class,
    'Concrete' => Concrete::class,
    'CreateTeamInput' => CreateTeamInput::class,
    'CreateUserInput' => CreateUserInput::class,
    'ErrorTestObj' => ErrorTestObj::class,
    'FavoriteColor' => FavoriteColor::class,
    'Human' => Human::class,
    'IIntrospectionInterfaceA' => IIntrospectionInterfaceA::class,
    'IIntrospectionInterfaceB' => IIntrospectionInterfaceB::class,
    'IIntrospectionInterfaceC' => IIntrospectionInterfaceC::class,
    'ImplementInterfaceA' => ImplementInterfaceA::class,
    'ImplementInterfaceB' => ImplementInterfaceB::class,
    'ImplementInterfaceC' => ImplementInterfaceC::class,
    'Int' => Types\IntType::class,
    'InterfaceA' => InterfaceA::class,
    'InterfaceB' => InterfaceB::class,
    'IntrospectionTestObject' => IntrospectionTestObject::class,
    'Mutation' => Mutation::class,
    'NestedOutputShape' => NestedOutputShape::class,
    'ObjectShape' => ObjectShape::class,
    'OutputShape' => OutputShape::class,
    'OutputTypeTestObj' => OutputTypeTestObj::class,
    'Query' => Query::class,
    'String' => Types\StringType::class,
    'Team' => Team::class,
    'User' => User::class,
    '__EnumValue' => __EnumValue::class,
    '__Field' => __Field::class,
    '__InputValue' => __InputValue::class,
    '__Schema' => __Schema::class,
    '__Type' => __Type::class,
    '__TypeKind' => __TypeKind::class,
  ];
  const classname<\Slack\GraphQL\Types\ObjectType> QUERY_TYPE = Query::class;
  const classname<\Slack\GraphQL\Types\ObjectType> MUTATION_TYPE = Mutation::class;

  public static async function resolveQuery(
    \Graphpinator\Parser\Operation\Operation $operation,
    \Slack\GraphQL\Variables $variables,
  ): Awaitable<GraphQL\ValidFieldResult<?dict<string, mixed>>> {
    return await Query::nullableOutput()->resolveAsync(new GraphQL\Root(), $operation, $variables);
  }

  public static async function resolveMutation(
    \Graphpinator\Parser\Operation\Operation $operation,
    \Slack\GraphQL\Variables $variables,
  ): Awaitable<GraphQL\ValidFieldResult<?dict<string, mixed>>> {
    return await Mutation::nullableOutput()->resolveAsync(new GraphQL\Root(), $operation, $variables);
  }
}
