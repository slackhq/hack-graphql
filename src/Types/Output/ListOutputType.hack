namespace Slack\GraphQL\Types;

use namespace HH\Lib\Vec;
use namespace Slack\GraphQL;

final class ListOutputType<TInner> extends OutputType<vec<TInner>> {

    public function __construct(private OutputType<TInner> $innerType) {}

    <<__Override>>
    public function getName(): ?string {
        return null;
    }

    public function getInnerType(): OutputType<TInner> {
        return $this->innerType;
    }

    <<__Override>>
    final public async function resolveAsync(
        vec<TInner> $value,
        \Graphpinator\Parser\Field\IHasFieldSet $field,
        GraphQL\__Private\Variables $vars,
    ): Awaitable<GraphQL\FieldResult> {
        $ret = vec[];
        $errors = vec[];
        $is_valid = true;

        $results = await Vec\map_async(
            $value,
            async $item ==> await $this->innerType->resolveAsync($item, $field, $vars),
        );

        foreach ($results as $idx => $result) {
            if ($result is GraphQL\ValidFieldResult) {
                $ret[] = $result->getValue();
            } else {
                $is_valid = false;
            }
            foreach ($result->getErrors() as $error) {
                $errors[] = $error->prependPath($idx);
            }
        }

        return $is_valid
            ? new GraphQL\ValidFieldResult($ret, $errors)
            : new GraphQL\InvalidFieldResult($errors);
    }
}
