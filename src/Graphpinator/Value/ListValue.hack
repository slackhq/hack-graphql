namespace Graphpinator\Value;

use namespace HH\Lib\Vec;

abstract class ListValue<T as Value> implements \Graphpinator\Value\Value, \IteratorAggregate<T> {

    protected \Graphpinator\Type\ListType $type;
    protected vec<T> $value;

    public function getIterator(): Iterator<T> {
        foreach ($this->value as $value) {
            yield $value;
        }
    }

    public function offsetExists(int $offset): bool {
        return \array_key_exists($offset, $this->value);
    }

    public function offsetGet(int $offset): Value {
        return $this->value[$offset] as Value;
    }

    public function offsetSet(int $offset, T $value): void {
        $this->value[$offset] = $value;
    }

    public function offsetUnset(int $offset): void {
        $this->value = Vec\filter_with_key($this->value, ($index, $_) ==> $index !== $offset);
    }
}
