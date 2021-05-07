namespace Graphpinator\Exception\Tokenizer;

final class StringLiteralInvalidEscape extends \Graphpinator\Exception\Tokenizer\TokenizerError {
    public function __construct(\Graphpinator\Common\Location $location) {
        $message = 'String literal with invalid escape sequence.';
        parent::__construct($message, $location);
    }
}
