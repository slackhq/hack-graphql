namespace Slack\GraphQL;

final class Resolver {
    public function __construct(private classname<BaseSchema> $schema) {}

    public async function resolve(
        \Graphpinator\Parser\ParsedRequest $request,
    ): Awaitable<shape('data' => ?dict<string, mixed>, ?'errors' => vec<string>)> {
        $schema = $this->schema;

        // TODO: what does the spec say should actually be contained in the output?
        $out = shape('data' => dict[]);
        foreach ($request->getOperations() as $operation) {
            $data = dict[];
            foreach ($operation->getFields() as $field) {
                $data[$field->getName()] = await $schema::resolveField($field, null);
            }

            $out['data'][$operation->getType()] = $data;
        }

        return $out;
    }
}
