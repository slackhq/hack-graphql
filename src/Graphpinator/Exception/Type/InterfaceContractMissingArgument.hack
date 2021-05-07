namespace Graphpinator\Exception\Type;

final class InterfaceContractMissingArgument extends \Graphpinator\Exception\Type\TypeError {
    public function __construct(string $childName, string $interfaceName, string $fieldName, string $argumentName) {
        $message = \HH\Lib\Str\format(
            'Type "%s" does not satisfy interface "%s" - argument "%s" on field "%s" is missing.',
            $childName,
            $interfaceName,
            $argumentName,
            $fieldName,
        );
        parent::__construct($message);
    }
}
