namespace Infinityloop\Utils\Exception;

final class InvalidSetOffset extends \Exception {
    public function __construct() {
        parent::__construct('Invalid offset for set - expecting int or null.');
    }
}
