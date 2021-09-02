
namespace Graphpinator\Exception\Tokenizer;

final class UnknownSymbol extends \Graphpinator\Exception\Tokenizer\TokenizerError {
    public function __construct(\Graphpinator\Common\Location $location) {
        $message = 'Unknown symbol.';
        parent::__construct($message, $location);
    }
}
