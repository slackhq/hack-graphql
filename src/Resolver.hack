


namespace Slack\GraphQL;

use namespace Slack\GraphQL;
use namespace HH\Lib\{C, Vec};

final class Resolver {

    public function __construct(private BaseSchema $schema) {}

    public async function resolve(IRequest $request): Awaitable<IResponse> {
        $response = new Response($request);
        if (!$request is WellformedRequest) {
            return $response;
        }

        $validator = new \Slack\GraphQL\Validation\Validator($this->schema);
        $errors = $validator->validate($request);
        if ($errors) {
            return $response->withErrors($errors);
        }

        try {
            list($data, $errors) = await $this->resolveRequest($request);
            $response = $response->withData($data);
        } catch (UserFacingError $e) {
            $errors = vec[$e];
        } catch (\Throwable $e) {
            $errors = vec[new FieldResolverError($e)];
        }

        return $response->withErrors($errors);
    }

    public async function resolveRequest(
        WellformedRequest $request,
    ): Awaitable<(?dict<string, mixed>, vec<UserFacingError>)> {
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

        return tuple($result->getValue(), $result->getErrors());
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
