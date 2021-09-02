


namespace Graphpinator\Parser\Exception;

final class EmptyRequest extends \Graphpinator\Parser\Exception\ParserError {
    public function __construct(\Graphpinator\Common\Location $location) {
        parent::__construct('Request is empty.', $location);
    }
}
