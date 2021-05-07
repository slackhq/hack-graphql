namespace Graphpinator\Exception\Type;

final class InterfaceContractMissingField extends \Graphpinator\Exception\Type\TypeError {
    public function __construct(string $childName, string $interfaceName, string $fieldName) {
        $message = \HH\Lib\Str\format(
            'Type "%s" does not satisfy interface "%s" - missing field "%s".',
            $childName,
            $interfaceName,
            $fieldName,
        );
        parent::__construct($message);
    }
}
