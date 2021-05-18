namespace Slack\GraphQL\Codegen;

final class ObjectBuilder<TField as IFieldBuilder> extends CompositeBuilder<TField> {
    const classname<\Slack\GraphQL\Types\ObjectType> SUPERCLASS = \Slack\GraphQL\Types\ObjectType::class;
}
