


namespace Slack\GraphQL;

use namespace HH\Lib\{C, Vec};

interface IFieldDefinition extends Introspection\__Field {
    public function getName(): string;
    public function getType(): Types\IOutputType;
    public function getArguments(): dict<string, Introspection\__InputValue>;
}

interface IResolvableFieldDefinition<TParent> extends IFieldDefinition {
    public function resolveAsync(
        TParent $parent,
        vec<\Graphpinator\Parser\Field\Field> $grouped_field_nodes,
        ExecutionContext $context,
    ): Awaitable<FieldResult<mixed>>;
}

final class FieldDefinition<TParent, TRet, TResolved> implements IResolvableFieldDefinition<TParent> {
    public function __construct(
        private string $name,
        private Types\IOutputTypeFor<TRet, TResolved> $type,
        private dict<string, Introspection\__InputValue> $arguments,
        private (function(
            TParent,
            dict<string, \Graphpinator\Parser\Value\Value>,
            Variables,
        ): Awaitable<TRet>) $resolver,
        private vec<FieldDirective> $directives,
    ) {}

    public async function resolveAsync(
        TParent $parent,
        vec<\Graphpinator\Parser\Field\Field> $grouped_field_nodes,
        ExecutionContext $context,
    ): Awaitable<FieldResult<TResolved>> {
        $resolver = $this->resolver;
        try {
            foreach ($this->directives as $directive) {
                await $directive->beforeResolve($this);
            }
            $value = await $resolver(
                $parent,
                // Validation guarantees all of the grouped field nodes have the same arguments, so it doesn't matter
                // which one we call getArgumentValues() on.
                C\firstx($grouped_field_nodes)->getArgumentValues(),
                $context->getVariableValues(),
            );
        } catch (UserFacingError $e) {
            return $this->type->resolveError($e);
        } catch (\Throwable $e) {
            return $this->type->resolveError(new FieldResolverError($e));
        }

        return await $this->type->resolveAsync($value, $grouped_field_nodes, $context);
    }

    public function getName(): string {
        return $this->name;
    }

    public function getType(): Types\IOutputTypeFor<TRet, TResolved> {
        return $this->type;
    }

    public function getArguments(): dict<string, Introspection\__InputValue> {
        return $this->arguments;
    }

    public function getDeprecationReason(): ?string {
        // TODO
        return null;
    }

    public function isDeprecated(): bool {
        // TODO
        return false;
    }

    public function getDescription(): ?string {
        // TODO
        return null;
    }

    public function getArgs(): vec<Introspection\__InputValue> {
        return vec($this->arguments);
    }
}
