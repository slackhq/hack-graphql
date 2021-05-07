namespace Graphpinator\Exception\Type;

final class FieldDirectiveNotCovariant extends \Graphpinator\Exception\Type\TypeError {

    public function __construct(string $childName, string $interfaceName, string $fieldName) {
        $message = \HH\Lib\Str\format(
            'Type "%s" does not satisfy interface "%s" - field "%s" has directive which is not covariant.',
            $childName,
            $interfaceName,
            $fieldName,
        );
        parent::__construct($message);
    }
}
