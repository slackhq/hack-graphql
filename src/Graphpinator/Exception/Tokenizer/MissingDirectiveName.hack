
namespace Graphpinator\Exception\Tokenizer;

final class MissingDirectiveName extends \Graphpinator\Exception\Tokenizer\TokenizerError {
    public function __construct(\Graphpinator\Common\Location $location) {
        $message = 'Missing directive name after @ symbol.';
        parent::__construct($message, $location);
    }
}
