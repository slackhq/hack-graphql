namespace Graphpinator\Type;

/**
 * Class InterfaceSet which is type safe container for InterfaceTypes.
 */
final class InterfaceSet extends \Infinityloop\Utils\ObjectMap<string, InterfaceType> {
    protected function getKey(InterfaceType $object): string {
        return $object->getName();
    }
}
