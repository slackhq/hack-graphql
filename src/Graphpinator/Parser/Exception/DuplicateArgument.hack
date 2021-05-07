namespace Graphpinator\Parser\Exception;

use namespace HH\Lib\Str;

final class DuplicateArgument extends \Graphpinator\Parser\Exception\ParserError {
    public function __construct(string $name, \Graphpinator\Common\Location $location) {
        $message = Str\format('Argument with name "%s" already exists on current field.', $name);

        parent::__construct($message, $location);
    }
}
