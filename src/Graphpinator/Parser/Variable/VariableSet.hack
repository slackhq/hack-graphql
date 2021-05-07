namespace Graphpinator\Parser\Variable;

final class VariableSet extends \Infinityloop\Utils\ObjectMap<string, Variable> {

    protected function getKey(Variable $object): string {
        return $object->getName();
    }
}
