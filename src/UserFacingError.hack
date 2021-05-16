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
    const type TError = shape(
        'message' => string,
        ?'location' => shape('line' => int, 'column' => int),
        ?'path' => vec<arraykey>,
    );

    private vec<arraykey> $reversePath = vec[];
    private ?\Graphpinator\Common\Location $location = null;

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

    final public function setPath(vec<arraykey> $path): this {
        $this->reversePath = Vec\reverse($path);
        return $this;
    }

    final public function getLocation(): ?\Graphpinator\Common\Location {
        return $this->location;
    }

    final public function setLocation(\Graphpinator\Common\Location $location): this {
        $this->location = $location;
        return $this;
    }

    final public function toShape(): this::TError {
        $out = shape('message' => $this->getMessage());
        $location = $this->getLocation();
        if ($location is nonnull) {
            $out['location'] = shape(
                'line' => $location->getLine(),
                'column' => $location->getColumn(),
            );
        }
        $path = $this->getPath();
        if ($path is nonnull) {
            $out['path'] = $path;
        }
        return $out;
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
