namespace Slack\GraphQL\Types;

use namespace HH\Lib\Vec;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Introspection;

final class PromiseType<TInner, TResolved> extends BaseType implements IOutputTypeFor<GraphQL\Promise<TInner>, TResolved> {
    use TOutputType<GraphQL\Promise<TInner>, TResolved>;

    public function __construct(private IOutputTypeFor<TInner, TResolved> $innerType) {}

    public async function resolveAsync(
        GraphQL\Promise<TInner> $value,
        vec<\Graphpinator\Parser\Field\IHasSelectionSet> $parent_nodes,
        GraphQL\ExecutionContext $context,
    ): Awaitable<GraphQL\FieldResult<TResolved>> {
        $value = await $value->resolve();
        return await $this->innerType->resolveAsync($value, $parent_nodes, $context);
    }

    public function unwrapType(): INamedOutputType {
        return $this->innerType->unwrapType();
    }

    public function getInnerType(): IOutputTypeFor<TInner, TResolved> {
        return $this->innerType;
    }

    <<__Override>>
    final public function getIntrospectionKind(): Introspection\__TypeKind {
        return $this->getInnerType()->getIntrospectionKind();
    }

    <<__Override>>
    final public function getIntrospectionName(): ?string {
        return $this->getInnerType()->getIntrospectionName();
    }

    <<__Override>>
    final public function getIntrospectionDescription(): ?string {
        return $this->getInnerType()->getIntrospectionDescription();
    }

    <<__Override>>
    final public function getIntrospectionFields(bool $include_deprecated = false): ?vec<Introspection\__Field> {
        return $this->getInnerType()->getIntrospectionFields();
    }

    <<__Override>>
    final public function getIntrospectionInterfaces(): ?vec<Introspection\__Type> {
        return $this->getInnerType()->getIntrospectionInterfaces();
    }

    <<__Override>>
    final public function getIntrospectionPossibleTypes(): ?vec<Introspection\__Type> {
        return $this->getInnerType()->getIntrospectionPossibleTypes();
    }

    <<__Override>>
    final public function getIntrospectionEnumValues(
        bool $include_deprecated = false,
    ): ?vec<Introspection\__EnumValue> {
        return $this->getInnerType()->getIntrospectionEnumValues();
    }

    <<__Override>>
    final public function getIntrospectionInputFields(
        bool $include_deprecated = false,
    ): ?vec<Introspection\__InputValue> {
        return $this->getInnerType()->getIntrospectionInputFields();
    }

    <<__Override>>
    final public function getIntrospectionOfType(): ?Introspection\__Type {
        return $this->getInnerType()->getIntrospectionOfType();
    }
}