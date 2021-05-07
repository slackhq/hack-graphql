namespace Graphpinator\Field;

/**
 * @method \Graphpinator\Field\Field current() : object
 * @method \Graphpinator\Field\Field offsetGet($offset) : object
 */
class FieldSet extends \Infinityloop\Utils\ObjectMap<string, Field> {
    protected function getKey(Field $object): string {
        return $object->getName();
    }
}
