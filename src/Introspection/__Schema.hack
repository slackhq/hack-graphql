namespace Slack\GraphQL\Introspection;

use namespace Slack\GraphQL;

<<GraphQL\ObjectType('__Schema', 'Schema introspection')>>
interface __Schema {

    <<GraphQL\Field('types', 'Types contained within the schema')>>
    public function getIntrospectionTypes(): vec<__Type>;

    <<GraphQL\Field('queryType', 'Query root type')>>
    public function getIntrospectionQueryType(): __Type;

    <<GraphQL\Field('mutationType', 'Mutation root type')>>
    public function getIntrospectionMutationType(): ?__Type;

    public function getIntrospectionType(string $name): ?NamedTypeDeclaration;
}
