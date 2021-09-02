
namespace Graphpinator\Parser\Exception;

use namespace HH\Lib\Str;

final class ExpectedArgumentName extends \Graphpinator\Parser\Exception\ExpectedError {
    public function __construct(\Graphpinator\Common\Location $location, string $token, string $message = '') {
        $message = Str\format('Expected argument or closing parenthesis, got "%s".', $token);
        parent::__construct($location, $token, $message);
    }
}
