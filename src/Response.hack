


namespace Slack\GraphQL;

use namespace HH\Lib\Vec;

/**
 * A GraphQL response providing access to data and errors output by the resolver,
 * as well as to the GraphQL request.
 */
interface IResponse {

    /**
     * @see https://spec.graphql.org/draft/#sec-Response
     */
    const type TShape = shape(
        ?'data' => ?dict<string, mixed>, // missing data and null data are both valid states with different meanings
        ?'errors' => vec<UserFacingError::TData>, // errors are optional but cannot be null (or empty) if present
        ?'extensions' => dict<string, mixed>,
    );

    /**
     * Get the data output by the resolver.
     */
    public function getData(): ?dict<string, mixed>;

    /**
     * Get any errors which occurred in the process of parsing, validating and resolving the request.
     */
    public function getErrors(): ?vec<UserFacingError>;

    /**
     * Get the request which gave rise to this response.
     */
    public function getRequest(): IRequest;

    /**
     * Cast the GraphQL response to a shape with `data`, `errors`, and `extensions` properties.
     */
    public function toShape(bool $verbose = false): this::TShape;
}

/**
 * An internal representation of a GraphQL response.
 *
 * Allows for mutating operations which are not exposed to downstream consumers.
 */
final class Response implements IResponse {
    private vec<UserFacingError> $errors = vec[];

    // A null value here represents that the data has been "nulled-out" by a child resolver
    // which threw an exception. An empty dict, on the other hand, means we never invoked any resolvers.
    private ?dict<string, mixed> $data = dict[];

    public function __construct(private IRequest $request) {}

    public function getData(): ?dict<string, mixed> {
        return $this->data;
    }

    public function getErrors(): ?vec<UserFacingError> {
        return $this->errors;
    }

    public function getRequest(): IRequest {
        return $this->request;
    }

    public function toShape(bool $verbose = false): this::TShape {
        $ret = shape();
        if ($this->data is null || $this->data) {
            $ret['data'] = $this->data;
        }
        if ($this->errors) {
            $ret['errors'] = Vec\map($this->errors, $error ==> $error->toShape($verbose));
        }
        return $ret;
    }

    /**
     * Set the `data` and `errors` properties from the resolver response.
     */
    public function withResult(ValidFieldResult<?dict<string, mixed>> $result): this {
        $this->data = $result->getValue();
        return $this->withErrors($result->getErrors()); // Add any errors which might exist
    }

    /**
     * Record an exception which occurred while resolving the request.
     */
    public function withException(\Throwable $error): this {
        return $this->withErrors(vec[new FieldResolverError($error)]);
    }

    /**
     * Record a user-facing error which occurred while resolving the request.
     */
    public function withUserError(UserFacingError $error): this {
        return $this->withErrors(vec[$error]);
    }

    /**
     * Record errors which occurred while resolving the request.
     */
    public function withErrors(vec<UserFacingError> $errors): this {
        $this->errors = $errors;
        return $this;
    }
}
