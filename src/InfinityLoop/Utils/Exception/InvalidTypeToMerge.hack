namespace Infinityloop\Utils\Exception;

final class InvalidTypeToMerge extends \Exception {
    public function __construct() {
        parent::__construct('Merged sets must be of the same type.');
    }
}
