namespace Slack\GraphQL;

interface IFieldDefinition<TParent> {
    public function resolveAsync(
        TParent $parent,
        \Graphpinator\Parser\Field\Field $field,
        __Private\Variables $vars,
    ): Awaitable<FieldResult>;
}

final class FieldDefinition<TParent, TRet> implements IFieldDefinition<TParent> {
    public function __construct(
        private Types\OutputType<TRet> $type,
        private (function(
            TParent,
            dict<string, \Graphpinator\Parser\Value\ArgumentValue>,
            __Private\Variables,
        ): Awaitable<TRet>) $resolver,
    ) {}

    public async function resolveAsync(
        TParent $parent,
        \Graphpinator\Parser\Field\Field $field,
        __Private\Variables $vars,
    ): Awaitable<FieldResult> {
        $resolver = $this->resolver;
        try {
            $value = await $resolver($parent, $field->getArguments() ?? dict[], $vars);
        } catch (UserFacingError $e) {
            return new InvalidFieldResult(vec[$e]);
        } catch (\Throwable $e) {
            return new InvalidFieldResult(vec[new FieldResolverError($e)]);
        }

        return await $this->type->resolveAsync($value, $field, $vars);
    }
}
