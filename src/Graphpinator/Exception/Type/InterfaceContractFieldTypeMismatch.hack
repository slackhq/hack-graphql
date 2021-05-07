namespace Graphpinator\Exception\Type;

final class InterfaceContractFieldTypeMismatch extends \Graphpinator\Exception\Type\TypeError {
    public function __construct(string $childName, string $interfaceName, string $fieldName) {
        $message = \HH\Lib\Str\format(
            'Type "%s" does not satisfy interface "%s" - field "%s" does not have a compatible type.',
            $childName,
            $interfaceName,
            $fieldName,
        );
        parent::__construct($message);
    }
}
