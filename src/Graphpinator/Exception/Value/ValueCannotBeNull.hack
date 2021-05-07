namespace Graphpinator\Exception\Value;

final class ValueCannotBeNull extends \Graphpinator\Exception\Value\ValueError {
    public function __construct() {
        $message = 'Not-null type with null value.';
        parent::__construct($message, true);
    }
}
