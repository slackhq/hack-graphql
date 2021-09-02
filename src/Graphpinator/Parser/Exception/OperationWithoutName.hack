


namespace Graphpinator\Parser\Exception;

final class OperationWithoutName extends \Graphpinator\Parser\Exception\ParserError {
    public function __construct(\Graphpinator\Common\Location $location) {
        $message = 'Multiple operations given, but not all have specified name.';
        parent::__construct($message, $location);
    }
}
