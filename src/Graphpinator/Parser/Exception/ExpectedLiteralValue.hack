
namespace Graphpinator\Parser\Exception;

use namespace HH\Lib\Str;

final class ExpectedLiteralValue extends \Graphpinator\Parser\Exception\ExpectedError {
    public function __construct(\Graphpinator\Common\Location $location, string $token, string $message = '') {
        $message = Str\format('Expected literal value as variable default value, got "%s".', $token);
        parent::__construct($location, $token, $message);
    }
}
