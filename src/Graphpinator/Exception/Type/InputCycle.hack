namespace Graphpinator\Exception\Type;

final class InputCycle extends \Graphpinator\Exception\Type\TypeError {
    public function __construct() {
        parent::__construct('Input cycle detected.');
    }
}
