namespace Slack\GraphQL;

interface IFieldDefinition<TParent> extends Introspection\__Field {
    public function resolveAsync(
        TParent $parent,
        \Graphpinator\Parser\Field\Field $field,
        Variables $vars,
    ): Awaitable<FieldResult<mixed>>;
}

final class FieldDefinition<TParent, TRet, TResolved> implements IFieldDefinition<TParent> {
    public function __construct(
        private string $name,
        private Types\OutputType<TRet, TResolved> $type,
        private (function(
            TParent,
            dict<string, \Graphpinator\Parser\Value\Value>,
            Variables,
        ): Awaitable<TRet>) $resolver,
    ) {}

    public async function resolveAsync(
        TParent $parent,
        \Graphpinator\Parser\Field\Field $field,
        Variables $vars,
    ): Awaitable<FieldResult<TResolved>> {
        $resolver = $this->resolver;
        try {
            $value = await $resolver($parent, $field->getArguments() ?? dict[], $vars);
        } catch (UserFacingError $e) {
            return $this->type->resolveError($e);
        } catch (\Throwable $e) {
            return $this->type->resolveError(new FieldResolverError($e));
        }

        return await $this->type->resolveAsync($value, $field, $vars);
    }

    public function getName(): string {
        return $this->name;
    }

    public function getType(): Introspection\__Type {
        if ($this->type is Types\NullableInputType<_> || $this->type is Types\NullableOutputType<_, _>) {
            return $this->type;
        }

        return new Introspection\NonNullable($this->type);
    }
}
