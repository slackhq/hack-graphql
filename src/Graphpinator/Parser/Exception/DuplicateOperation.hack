


namespace Graphpinator\Parser\Exception;

final class DuplicateOperation extends \Graphpinator\Parser\Exception\ParserError {
    public function __construct(\Graphpinator\Common\Location $location) {
        parent::__construct('Operation with this name already exists in current request.', $location);
    }
}
