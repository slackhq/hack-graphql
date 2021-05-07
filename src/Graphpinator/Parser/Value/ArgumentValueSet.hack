namespace Graphpinator\Parser\Value;

final class ArgumentValueSet extends \Infinityloop\Utils\ObjectMap<string, ArgumentValue> {

    protected function getKey(ArgumentValue $object): string {
        return $object->getName();
    }
}
