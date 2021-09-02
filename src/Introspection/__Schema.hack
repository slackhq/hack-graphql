


namespace Slack\GraphQL\Introspection;

use namespace Slack\GraphQL;

<<GraphQL\ObjectType('__Schema', 'Schema introspection')>>
interface __Schema {

    <<GraphQL\Field('types', 'Types contained within the schema')>>
    public function getTypes(): vec<__Type>;

    <<GraphQL\Field('queryType', 'Query root type')>>
    public function getIntrospectionQueryType(): __Type;

    <<GraphQL\Field('mutationType', 'Mutation root type')>>
    public function getIntrospectionMutationType(): ?__Type;

    <<GraphQL\Field('subscriptionType', 'Subscription root type')>>
    public function getIntrospectionSubscriptionType(): ?__Type;

    <<GraphQL\Field('directives', 'Directives supported by the schema')>>
    public function getDirectives(): vec<__Directive>;
}
