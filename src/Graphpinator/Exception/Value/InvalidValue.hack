namespace Graphpinator\Exception\Value;

use namespace HH\Lib\Str;

final class InvalidValue extends \Graphpinator\Exception\Value\ValueError {
    public function __construct(string $type, mixed $rawValue, bool $outputable) {
        $message = Str\format('Invalid value resolved for type "%s" - got %s.', $type, $this->printValue($rawValue));

        parent::__construct($message, $outputable);
    }

    private function printValue(mixed $rawValue): string {
        if ($rawValue === null || \is_scalar($rawValue)) {
            return \json_encode($rawValue);
        }

        if (\is_array($rawValue)) {
            return 'list';
        }

        if ($rawValue is KeyedContainer<_, _>) {
            return 'object';
        }

        return \get_class($rawValue);
    }
}
