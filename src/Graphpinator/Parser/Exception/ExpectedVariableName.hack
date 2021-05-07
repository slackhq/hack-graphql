namespace Graphpinator\Parser\Exception;

use namespace HH\Lib\Str;

final class ExpectedVariableName extends \Graphpinator\Parser\Exception\ExpectedError {
    public function __construct(\Graphpinator\Common\Location $location, string $token, string $message = '') {
        $message = Str\format('Expected variable or closing parenthesis, got "%s".', $token);
        parent::__construct($location, $token, $message);
    }
}
