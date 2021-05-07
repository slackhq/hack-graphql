namespace Infinityloop\Utils\Exception;

final class ItemAlreadyExists extends \Exception {
    public function __construct() {
        parent::__construct('Item already exists, use $allowReplace if you wish to replace.');
    }
}
