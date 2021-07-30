


namespace Slack\GraphQL;

use namespace Slack\GraphQL;
use namespace HH\Lib\{C, Vec};

final class Resolver {

    public function __construct(private BaseSchema $schema) {}

    /**
     * Validate and resolve a GraphQL request against the schema..
     */
    public async function resolve(IRequest $request): Awaitable<IResponse> {
        $response = new Response($request);
        // If the request is malformed, we can't proceed with execution.
        if ($request is MalformedRequest) {
            return $response->withErrors($request->getErrors());
        }
        $request as WellformedRequest;

        $validator = new GraphQL\Validation\Validator($this->schema);
        $errors = $validator->validate($request);
        if ($errors) {
            return $response->withErrors($errors);
        }

        try {
            $result = await $this->resolveRequest($request);
            return $response->withResult($result);
        } catch (UserFacingError $e) {
            return $response->withUserError($e);
        } catch (\Throwable $e) {
            return $response->withException($e);
        }
    }

    public async function resolveRequest(
        WellformedRequest $request,
    ): Awaitable<ValidFieldResult<?dict<string, mixed>>> {
        $schema = $this->schema;

        $query = $request->getQuery();
        $operation = $request->getOperation();

        $context = new ExecutionContext(
            $this->coerceVariables($operation->getVariables(), $request->getVariables()),
            $query->getFragments(),
        );

        $operation_type = $operation->getType();
        switch ($operation_type) {
            case 'query':
                $result = await $schema->resolveQuery($operation, $context);
                break;
            case 'mutation':
                invariant($schema::MUTATION_TYPE, 'mutation operation not supported for schema');
                $result = await $schema->resolveMutation($operation, $context);
                break;
            default:
                throw new \Error('Unsupported operation: '.$operation_type);
        }

        return $result;
    }

    private function coerceVariables(
        dict<string, \Graphpinator\Parser\Variable\Variable> $nodes,
        dict<string, mixed> $raw_values,
    ): dict<string, mixed> {
        $coerced_values = dict[];
        foreach ($nodes as $name => $node) {
            $type = Types\TInputType::fromNode($this->schema, $node->getType());
            if (C\contains_key($raw_values, $name)) {
                try {
                    $coerced_values[$name] = $type->coerceValue($raw_values[$name]);
                } catch (UserFacingError $e) {
                    throw $e->prependMessage('Invalid value for variable "%s"', $name);
                }
                continue;
            }
            $default_node = $node->getDefault();
            if ($default_node is nonnull) {
                try {
                    $coerced_values[$name] = $type->coerceNode($default_node, dict[]);
                } catch (UserFacingError $e) {
                    throw $e->prependMessage('Invalid default value for variable "%s"', $name);
                }
                continue;
            }
            GraphQL\assert($type is Types\NullableInputType<_>, 'Missing value for required variable "%s"', $name);
        }
        return $coerced_values;
    }
}
