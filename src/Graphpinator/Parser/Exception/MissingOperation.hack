namespace Graphpinator\Parser\Exception;

final class MissingOperation extends \Graphpinator\Parser\Exception\ParserError {
    public function __construct(\Graphpinator\Common\Location $location) {
        $message = 'No GraphQL operation requested.';
        parent::__construct($message, $location);
    }
}
