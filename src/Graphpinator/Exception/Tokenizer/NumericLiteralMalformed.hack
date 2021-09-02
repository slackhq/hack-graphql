
namespace Graphpinator\Exception\Tokenizer;

final class NumericLiteralMalformed extends \Graphpinator\Exception\Tokenizer\TokenizerError {
    public function __construct(\Graphpinator\Common\Location $location) {
        $message = 'Numeric literal incorrectly formed.';
        parent::__construct($message, $location);
    }
}
