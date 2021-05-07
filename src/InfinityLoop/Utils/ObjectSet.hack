namespace Infinityloop\Utils;

use namespace HH\Lib\Vec;

abstract class ObjectSet<T> implements \HH\KeyedIterator<int, T>, \ArrayAccess<int, T>, \Countable {
    const classname<\Infinityloop\Utils\Exception\UnknownOffset> EXCEPTION_UNKNOWN_OFFSET =
        \Infinityloop\Utils\Exception\UnknownOffset::class;

    private vec<T> $data = vec[];

    public function __construct(vec<T> $data = vec[]) {
        foreach ($data as $object) {
            $this->offsetSet(null, $object);
        }
    }

    public function key(): int {
        return \key($this->data);
    }

    public function reindex(): this {
        $this->data = vec($this->data);

        return $this;
    }

    public function merge(ObjectSet<T> $objectSet, bool $allowReplace = false): this {
        foreach ($objectSet as $offset => $object) {
            $this->offsetSet($allowReplace ? $offset : null, $object);
        }

        return $this;
    }

    public function toVec(): vec<T> {
        return $this->data;
    }

    public function current(): T {
        return \current($this->data);
    }

    public function next(): void {
        $mutable = $this->data;
        \next(inout $mutable);
        $this->data = $mutable;
    }

    public function valid(): bool {
        return \key($this->data) !== null;
    }

    public function rewind(): void {
        $mutable = $this->data;
        \reset(inout $mutable);
        $this->data = $mutable;
    }

    public function count(): int {
        return \count($this->data);
    }

    public function offsetExists(int $offset): bool {
        return \array_key_exists($offset, $this->data);
    }

    public function offsetGet(int $offset): T {
        if (!$this->offsetExists($offset)) {
            $exception = static::EXCEPTION_UNKNOWN_OFFSET;

            throw new $exception($offset);
        }

        return $this->data[$offset];
    }

    public function offsetSet(?int $offset, T $value): void {
        if ($offset === null) {
            $this->data[] = $value;

            return;
        }

        $this->data[$offset] = $value;
        return;
    }

    public function offsetUnset(int $offset): void {
        if (!$this->offsetExists($offset)) {
            $exception = static::EXCEPTION_UNKNOWN_OFFSET;

            throw new $exception($offset);
        }

        $this->data = Vec\filter_with_key($this->data, ($key, $_) ==> $key !== $offset);
    }
}
