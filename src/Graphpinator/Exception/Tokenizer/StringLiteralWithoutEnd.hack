


namespace Graphpinator\Exception\Tokenizer;

final class StringLiteralWithoutEnd extends \Graphpinator\Exception\Tokenizer\TokenizerError {
    public function __construct(\Graphpinator\Common\Location $location) {
        $message = 'String literal without proper end.';
        parent::__construct($message, $location);
    }
}
