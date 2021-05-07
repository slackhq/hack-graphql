namespace Graphpinator\Type;

/**
 * Class TypeSet which is type safe container for ConcreteTypes.
 *
 * @method \Graphpinator\Type\Type current() : object
 * @method \Graphpinator\Type\Type offsetGet($offset) : object
 */
final class TypeSet extends \Infinityloop\Utils\ObjectSet<\Graphpinator\Type\Type> {

    protected function getKey(\Graphpinator\Type\Type $object): string {
        return $object->getName();
    }
}
