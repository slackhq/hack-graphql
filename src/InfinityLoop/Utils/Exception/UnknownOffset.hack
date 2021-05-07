namespace Infinityloop\Utils\Exception;

final class UnknownOffset extends \Exception {
    public function __construct(arraykey $offset) {
        parent::__construct(\sprintf('Item with offset "%s" does not exist.', $offset));
    }
}
