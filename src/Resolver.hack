namespace Slack\GraphQL;

final class Resolver {
    public function __construct(private classname<BaseSchema> $schema) {}

    public async function resolve(
        \Graphpinator\Parser\ParsedRequest $request,
        ?dict<string, mixed> $variables = null,
    ): Awaitable<shape('data' => ?dict<string, mixed>, ?'errors' => vec<string>)> {
        // TODO: validate variables against $schema
        $schema = $this->schema;

        // TODO: what does the spec say should actually be contained in the output?
        $out = shape('data' => dict[]);
        foreach ($request->getOperations() as $operation) {
            $operation_type = $operation->getType();
            switch ($operation_type) {
                case 'query':
                    $data = await $schema::resolveQuery($operation, $variables ?? dict[]);
                    break;
                default:
                    throw new \Error('Unsupported operation: '.$operation_type);
            }

            $out['data'][$operation_type] = $data;
        }

        return $out;
    }
}
