namespace Slack\GraphQL;

use namespace HH\Lib\{C, Vec};

final class Resolver {

    /**
     * @see https://spec.graphql.org/draft/#sec-Response
     */
    const type TResponse = shape(
        ?'data' => ?dict<string, mixed>, // missing data and null data are both valid states with different meanings
        ?'errors' => vec<shape( // errors are optional but cannot be null (or empty) if present
            'message' => string,
            ?'location' => shape('line' => int, 'column' => int),
            ?'path' => vec<arraykey>,
        )>,
        ?'extensions' => dict<string, mixed>,
    );

    public function __construct(private classname<BaseSchema> $schema) {}

    /**
     * Operation name must be specified if the GraphQL request contains multiple operations.
     *
     * @see https://spec.graphql.org/draft/#sec-Execution
     */
    public async function resolve(
        \Graphpinator\Parser\ParsedRequest $request,
        ?dict<string, mixed> $variables = null,
        ?string $operation_name = null,
    ): Awaitable<this::TResponse> {
        $ret = shape();
        $errors = vec[];

        try {
            list($ret['data'], $errors) = await $this->resolveImpl($request, $variables, $operation_name);
        } catch (UserFacingError $e) {
            $errors = vec[$e];
        } catch (\Throwable $e) {
            // TODO: This shoud not happen; if it does, it's a bug in the GraphQL framework. Every exception should
            // either be UserFacingError, or caught somewhere. However, we probably still want to catch arbitrary
            // exceptions here just in case and return *some* reasonable response.
            throw $e; // for now, so as to not break existing tests
        }

        if (!C\is_empty($errors)) {
            $ret['errors'] = Vec\map(
                $errors,
                $e ==> {
                    $out = shape('message' => $e->getMessage());
                    $path = $e->getPath();
                    if ($path is nonnull) {
                        $out['path'] = $path;
                    }
                    return $out;
                },
            );
            return $ret;
        }
        return $ret;
    }

    public async function resolveImpl(
        \Graphpinator\Parser\ParsedRequest $request,
        ?dict<string, mixed> $variables,
        ?string $operation_name,
    ): Awaitable<(?dict<string, mixed>, vec<UserFacingError>)> {
        // TODO: validate variables against $schema
        $schema = $this->schema;

        if ($operation_name is nonnull) {
            \Slack\GraphQL\assert(
                C\contains_key($request->getOperations(), $operation_name),
                'Operation %s not found in the request',
                $operation_name,
            );
            $operation = $request->getOperations()[$operation_name];
        } else {
            \Slack\GraphQL\assert(
                C\count($request->getOperations()) === 1,
                'Operation name must be specified if the request contains multiple',
            );
            $operation = C\onlyx($request->getOperations());
        }

        $operation_type = $operation->getType();
        switch ($operation_type) {
            case 'query':
                $result = await $schema::resolveQuery($operation, $variables ?? dict[]);
                break;
            case 'mutation':
                invariant($schema::SUPPORTS_MUTATIONS, 'mutation operation not supported for schema');
                $result = await $schema::resolveMutation($operation, $variables ?? dict[]);
                break;
            default:
                throw new \Error('Unsupported operation: '.$operation_type);
        }

        return tuple($result->getValue(), $result->getErrors());
    }
}
