namespace Graphpinator\Parser\Exception;

<<__ConsistentConstruct>>
abstract class ExpectedError extends \Graphpinator\Parser\Exception\ParserError {
    public function __construct(\Graphpinator\Common\Location $location, string $token, string $message = '') {
        parent::__construct($message, $location);
    }
}
