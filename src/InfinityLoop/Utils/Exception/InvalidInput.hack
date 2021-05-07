namespace Infinityloop\Utils\Exception;

final class InvalidInput extends \Exception {
    public function __construct(string $className) {
        parent::__construct(\sprintf('Invalid item given for a class, expected instanceof %s.', $className));
    }
}
