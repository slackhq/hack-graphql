namespace Slack\GraphQL;

use namespace HH\Lib\Vec;

interface IResponse {

    /**
     * @see https://spec.graphql.org/draft/#sec-Response
     */
    const type TShape = shape(
        ?'data' => ?dict<string, mixed>, // missing data and null data are both valid states with different meanings
        ?'errors' => vec<UserFacingError::TData>, // errors are optional but cannot be null (or empty) if present
        ?'extensions' => dict<string, mixed>,
    );

    public function getData(): ?dict<string, mixed>;
    public function getErrors(): ?vec<UserFacingError>;
    public function getRequest(): IRequest;
    public function toShape(bool $verbose = false): this::TShape;
}

final class Response implements IResponse {
    private vec<UserFacingError> $errors = vec[];

    // A null value here represents that the data has been "nulled-out" by a child resolver
    // which threw an exception. An empty dict, on the other hand, means we never invoked any resolvers.
    private ?dict<string, mixed> $data = dict[];

    public function __construct(private IRequest $request) {
        if ($request is MalformedRequest) {
            $this->errors = $request->getErrors();
        }
    }

    public function getData(): ?dict<string, mixed> {
        return $this->data;
    }

    public function withData(?dict<string, mixed> $data): this {
        $this->data = $data;
        return $this;
    }

    public function getErrors(): ?vec<UserFacingError> {
        return $this->errors;
    }

    public function withErrors(vec<UserFacingError> $errors): this {
        $this->errors = $errors;
        return $this;
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
}
