namespace Slack\GraphQL;

use namespace HH\Lib\{C, Str, Vec};

function assert(
    bool $condition,
    Str\SprintfFormatString $message,
    mixed ...$args
): void {
    if (!$condition) {
        throw new UserFacingError('%s', \vsprintf($message, $args));
    }
}

/**
 * Any error that should be included in the GraphQL response's "errors" field.
 */
class UserFacingError extends \Exception {
    private vec<arraykey> $reversePath = vec[];

    public function __construct(
      Str\SprintfFormatString $message,
      mixed ...$args
    ): void {
        parent::__construct(\vsprintf($message, $args));
    }

    final public function prependMessage(
        Str\SprintfFormatString $message,
        mixed ...$args
    ): this {
        $this->message = \vsprintf($message, $args).': '.$this->message;
        return $this;
    }

    final public function prependPath(arraykey $key): this {
        $this->reversePath[] = $key;
        return $this;
    }

    final public function getPath(): ?vec<arraykey> {
        if (C\is_empty($this->reversePath)) {
            // return null instead of an empty path, to indicate that it shouldn't be included in the GraphQL response
            return null;
        }
        return Vec\reverse($this->reversePath);
    }
}

final class FieldResolverError extends UserFacingError {
    public function __construct(private \Throwable $cause) {
        parent::__construct('Caught exception while resolving field.');
    }

    public function getCause(): \Throwable {
        return $this->cause;
    }
}
