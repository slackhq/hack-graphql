


namespace Graphpinator\Exception\Tokenizer;

final class NumericLiteralNegativeFraction extends \Graphpinator\Exception\Tokenizer\TokenizerError {
    public function __construct(\Graphpinator\Common\Location $location) {
        $message = 'Negative fraction part in numeric value.';
        parent::__construct($message, $location);
    }
}
