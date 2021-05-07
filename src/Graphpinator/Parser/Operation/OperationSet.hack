namespace Graphpinator\Parser\Operation;

final class OperationSet extends \Infinityloop\Utils\ObjectMap<string, Operation> {
    protected function getKey(Operation $object): string {
        return $object->getName() ?? '';
    }
}
