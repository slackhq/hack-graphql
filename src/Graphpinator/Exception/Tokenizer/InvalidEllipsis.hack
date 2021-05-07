namespace Graphpinator\Exception\Tokenizer;

final class InvalidEllipsis extends \Graphpinator\Exception\Tokenizer\TokenizerError {
    public function __construct(\Graphpinator\Common\Location $location) {
        $message = 'Invalid ellipsis - three dots are expected for ellipsis.';
        parent::__construct($message, $location);
    }
}
