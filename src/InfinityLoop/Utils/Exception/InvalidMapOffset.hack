namespace Infinityloop\Utils\Exception;

final class InvalidMapOffset extends \Exception {
    public function __construct() {
        parent::__construct('Invalid offset for map - expecting string.');
    }
}
