
namespace Graphpinator\Exception\Tokenizer;

final class MissingVariableName extends \Graphpinator\Exception\Tokenizer\TokenizerError {
    public function __construct(\Graphpinator\Common\Location $location) {
        $message = 'Missing variable name after $ symbol.';
        parent::__construct($message, $location);
    }
}
