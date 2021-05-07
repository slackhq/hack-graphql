namespace Slack\GraphQL;

use namespace HH\Lib\Str;

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
final class UserFacingError extends \Exception {
    public function __construct(
      Str\SprintfFormatString $message,
      mixed ...$args
    ): void {
        parent::__construct(\vsprintf($message, $args));
    }
}
