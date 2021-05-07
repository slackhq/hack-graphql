namespace Graphpinator\Exception\Type;

final class InterfaceDirectivesNotPreserved extends \Graphpinator\Exception\Type\TypeError {
    public function __construct() {
        parent::__construct('Interface directives must be preserved during inheritance (invariance).');
    }
}
