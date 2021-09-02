
namespace Graphpinator\Exception\Tokenizer;

final class NumericLiteralFollowedByName extends \Graphpinator\Exception\Tokenizer\TokenizerError {
    public function __construct(\Graphpinator\Common\Location $location) {
        $message = 'Numeric literal cannot be followed by name.';
        parent::__construct($message, $location);
    }
}
