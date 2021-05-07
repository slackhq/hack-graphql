namespace Graphpinator\Parser\Exception;

final class UnknownOperationType extends \Graphpinator\Parser\Exception\ParserError {
    public function __construct(\Graphpinator\Common\Location $location) {
        $message = 'Unknown operation type - one of: query, mutation, subscription (case-sensitive).';
        parent::__construct($message, $location);
    }
}
