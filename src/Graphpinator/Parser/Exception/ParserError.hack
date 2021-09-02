
namespace Graphpinator\Parser\Exception;

abstract class ParserError extends \Graphpinator\Exception\GraphpinatorBase {
    public function __construct(string $message, \Graphpinator\Common\Location $location) {
        parent::__construct($message);

        $this->location = $location;
    }

    final public function isOutputable(): bool {
        return true;
    }
}
