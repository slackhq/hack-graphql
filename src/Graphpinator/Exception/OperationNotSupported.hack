namespace Graphpinator\Exception;

final class OperationNotSupported extends \Graphpinator\Exception\GraphpinatorBase {
    public function __construct() {
        $message = 'This method is not supported on this object.';
        parent::__construct($message);
    }
}
