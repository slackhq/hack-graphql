namespace Slack\GraphQL;

interface IFieldDefinition<TParent> extends Introspection\IntrospectableField {
    public function resolveAsync(
        classname<Introspection\IntrospectableSchema> $schema,
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
            classname<Introspection\IntrospectableSchema>,
            TParent,
            dict<string, \Graphpinator\Parser\Value\ArgumentValue>,
            Variables,
        ): Awaitable<TRet>) $resolver,
    ) {}

    public async function resolveAsync(
        classname<Introspection\IntrospectableSchema> $schema,
        TParent $parent,
        \Graphpinator\Parser\Field\Field $field,
        Variables $vars,
    ): Awaitable<FieldResult<TResolved>> {
        $resolver = $this->resolver;
        try {
            $value = await $resolver($schema, $parent, $field->getArguments() ?? dict[], $vars);
        } catch (UserFacingError $e) {
            return $this->type->resolveError($e);
        } catch (\Throwable $e) {
            return $this->type->resolveError(new UserFacingError('Failed resolving field: %s', $e->getMessage()));
        }

        return await $this->type->resolveAsync($schema, $value, $field, $vars);
    }

    public function getName(): string {
        return $this->name;
    }

    public function getDescription(): ?string {
        // TODO
        return null;
    }

    public function getArgs(): vec<Introspection\IntrospectableInputValue> {
        // TODO
        return vec[];
    }

    public function getType(): Introspection\IntrospectableType {
        return $this->type;
    }

    public function isDeprecated(): bool {
        // TODO
        return false;
    }

    public function getDeprecationReason(): ?string {
        // TODO
        return null;
    }
}
