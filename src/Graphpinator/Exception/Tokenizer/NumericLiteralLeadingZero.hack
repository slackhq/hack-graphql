
namespace Graphpinator\Exception\Tokenizer;

final class NumericLiteralLeadingZero extends \Graphpinator\Exception\Tokenizer\TokenizerError {
    public function __construct(\Graphpinator\Common\Location $location) {
        $message = 'Numeric literal with leading zeroes.';
        parent::__construct($message, $location);
    }
}
