namespace Slack\GraphQL\Types;

use namespace HH\Lib\Vec;
use namespace Slack\GraphQL;

final class ListOutputType<TInner, TResolved> extends OutputType<vec<TInner>, vec<mixed>> {

    public function __construct(private OutputType<TInner, TResolved> $inner_type) {}

    <<__Override>>
    public function getName(): ?string {
        return null;
    }

    <<__Override>>
    final public function unwrapType(): NamedOutputType {
        return $this->inner_type->unwrapType();
    }

    <<__Override>>
    final public async function resolveAsync(
        vec<TInner> $value,
        \Graphpinator\Parser\Field\IHasFieldSet $field,
        GraphQL\Variables $vars,
    ): Awaitable<GraphQL\FieldResult<vec<mixed>>> {
        $ret = vec[];
        $errors = vec[];
        $is_valid = true;

        $results = await Vec\map_async(
            $value,
            async $item ==> await $this->inner_type->resolveAsync($item, $field, $vars),
        );

        foreach ($results as $idx => $result) {
            if ($result is GraphQL\ValidFieldResult<_>) {
                $ret[] = $result->getValue();
            } else {
                $is_valid = false;
            }
            foreach ($result->getErrors() as $error) {
                $errors[] = $error->prependPath($idx);
            }
        }

        return $is_valid ? new GraphQL\ValidFieldResult($ret, $errors) : new GraphQL\InvalidFieldResult($errors);
    }

    <<__Override>>
    final public function introspect(): GraphQL\Introspection\NonNullableType {
        return new GraphQL\Introspection\NonNullableType(
            new GraphQL\Introspection\ListType($this->inner_type->introspect()),
        );
    }
}
