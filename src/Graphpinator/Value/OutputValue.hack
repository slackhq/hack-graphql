namespace Graphpinator\Value;

interface OutputValue extends \Graphpinator\Value\ResolvedValue, \JsonSerializable {
    public function jsonSerialize(): mixed;
}
