


namespace Graphpinator\Exception\Tokenizer;

final class SourceUnexpectedEnd extends \Graphpinator\Exception\Tokenizer\TokenizerError {
    public function __construct(\Graphpinator\Common\Location $location) {
        $message = 'Unexpected end of input. Probably missing closing brace?';
        parent::__construct($message, $location);
    }
}
