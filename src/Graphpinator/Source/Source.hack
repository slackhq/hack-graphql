
namespace Graphpinator\Source;

interface Source<T> extends \HH\KeyedIterator<int, T> {
    public function hasChar(): bool;

    public function getChar(): string;

    public function getLocation(): \Graphpinator\Common\Location;
}
