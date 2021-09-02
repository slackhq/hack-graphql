


namespace Graphpinator\Exception\Tokenizer;

final class StringLiteralNewLine extends \Graphpinator\Exception\Tokenizer\TokenizerError {
    public function __construct(\Graphpinator\Common\Location $location) {
        $message = 'Simple string literal cannot span across multiple lines. Use block literal or escape sequence.';
        parent::__construct($message, $location);
    }
}
