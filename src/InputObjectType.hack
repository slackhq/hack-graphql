
namespace Slack\GraphQL;

/**
* GraphQL input type: https://graphql.org/learn/schema/#input-types
*
* Annotate shapes with this attribute to support accepting them as inputs within
* mutations.
*/
class InputObjectType extends __Private\GraphQLTypeInfo implements \HH\TypeAliasAttribute {}
