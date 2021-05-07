namespace Graphpinator\EnumItem;

final class EnumItemSet extends \Infinityloop\Utils\ObjectSet<EnumItem> {
    public function getVec(): vec<string> {
        $return = vec[];

        foreach ($this as $enumItem) {
            $return[] = $enumItem->getName();
        }

        return $return;
    }

    protected function getKey(EnumItem $object): string {
        return $object->getName();
    }
}
