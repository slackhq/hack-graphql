


namespace Slack\GraphQL;

use namespace Slack\GraphQL;
use namespace HH\Lib\C;

/**
 * IRequest represents a request to the GraphQL server. The request may be wellformed or malformed;
 * in the case of a malformed request, parsing has failed and the request will not be further validated
 * or executed.
 *
 * This interface mostly exists as a way to pass useful metadata back to the client; e.g. callers can
 * call `$request->getOperationName()` to discover the name of the GraphQL query or mutation which the
 * request would execute.
 */
interface IRequest {

    /**
     * Get any variables included in the request.
     */
    public function getVariables(): dict<string, mixed>;

    /**
     * Get the name of the operation which the request will execute, or which was passed in with the request
     * (in the case of an invalid operation name).
     */
    public function getOperationName(): ?string;
}

/**
 * Shared functionality for GraphQL requests.
 */
abstract class Request implements IRequest {

    /**
     * Build a GraphQL request.
     *
     * A request contains at leat one operation. An operation name must be provided if the request
     * contains multiple operations.
     *
     * @see https://spec.graphql.org/draft/#sec-Execution
     */
    final public static function build(
        string $input,
        dict<string, mixed> $variables,
        ?string $operation_name = null,
    ): IRequest {
        try {
            $query = self::parseQuery($input);
            $operation = self::parseOperation($query, $operation_name);
        } catch (UserFacingError $error) {
            return new MalformedRequest($input, $variables, vec[$error], $operation_name);
        }

        return new WellformedRequest($input, $variables, $query, $operation);
    }

    private static function parseQuery(string $input): \Graphpinator\Parser\ParsedRequest {
        $source = new \Graphpinator\Source\StringSource($input);
        $parser = new \Graphpinator\Parser\Parser($source);

        try {
            return $parser->parse();
        } catch (\Graphpinator\Exception\GraphpinatorBase $e) {
            $user_facing_error = new UserFacingError('%s', $e->getMessage());
            $location = $e->getLocation();
            if ($location) {
                $user_facing_error->setLocation($location);
            }
            $path = $e->getPath()?->jsonSerialize();
            if ($path) {
                $user_facing_error->setPath($path);
            }
            throw $user_facing_error;
        }
    }

    private static function parseOperation(
        \Graphpinator\Parser\ParsedRequest $query,
        ?string $operation_name,
    ): \Graphpinator\Parser\Operation\Operation {
        if ($operation_name is nonnull) {
            GraphQL\assert(
                C\contains_key($query->getOperations(), $operation_name),
                'Operation %s not found in the request',
                $operation_name,
            );
            return $query->getOperations()[$operation_name];
        } else {
            GraphQL\assert(
                C\count($query->getOperations()) === 1,
                'Operation name must be specified if the request contains multiple',
            );
            return C\onlyx($query->getOperations());
        }
    }

    public function __construct(private string $input, private dict<string, mixed> $variables = dict[]) {}

    public function getVariables(): dict<string, mixed> {
        return $this->variables;
    }
}

/**
 * A request that could not be parsed or that contained an invalid operation name.
 */
final class MalformedRequest extends Request {
    public function __construct(
        string $input,
        dict<string, mixed> $variables,
        private vec<UserFacingError> $errors,
        private ?string $operation_name = null,
    ) {
        parent::__construct($input, $variables);
    }

    public function getOperationName(): ?string {
        return $this->operation_name;
    }

    /**
     * Get errors describing why this request is malformed.
     */
    public function getErrors(): vec<UserFacingError> {
        return $this->errors;
    }
}

/**
 * A parsed request which is ready to be validated and potentially executed.
 */
final class WellformedRequest extends Request {
    public function __construct(
        string $input,
        dict<string, mixed> $variables,
        private \Graphpinator\Parser\ParsedRequest $query,
        private \Graphpinator\Parser\Operation\Operation $operation,
    ) {
        parent::__construct($input, $variables);
    }

    public function getOperationName(): string {
        return $this->operation->getName();
    }

    /**
     * Get the query parsed from this request's raw input.
     */
    public function getQuery(): \Graphpinator\Parser\ParsedRequest {
        return $this->query;
    }

    /**
     * Get the operation which will be executed by the request (if the request is valid).
     */
    public function getOperation(): \Graphpinator\Parser\Operation\Operation {
        return $this->operation;
    }
}
