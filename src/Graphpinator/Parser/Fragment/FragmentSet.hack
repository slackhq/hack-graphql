namespace Graphpinator\Parser\Fragment;

final class FragmentSet extends \Infinityloop\Utils\ObjectMap<string, Fragment> {
    protected function getKey(Fragment $object): string {
        return $object->getName();
    }
}
