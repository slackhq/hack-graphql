
namespace Graphpinator\Parser\Exception;

final class UnexpectedEnd extends \Graphpinator\Parser\Exception\ParserError {
    public function __construct(\Graphpinator\Common\Location $location) {
        $message = 'Unexpected end of input. Probably missing closing brace?';
        parent::__construct($message, $location);
    }
}
