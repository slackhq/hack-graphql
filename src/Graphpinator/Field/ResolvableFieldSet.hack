namespace Graphpinator\Field;

/**
 * @method \Graphpinator\Field\ResolvableField current() : object
 * @method \Graphpinator\Field\ResolvableField offsetGet($offset) : object
 */
final class ResolvableFieldSet<T> extends \Infinityloop\Utils\ObjectMap<string, ResolvableField<T>> {
    protected function getKey(ResolvableField<T> $object): string {
        return $object->getName();
    }
}
