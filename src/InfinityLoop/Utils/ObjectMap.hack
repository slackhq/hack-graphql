namespace Infinityloop\Utils;

use namespace HH\Lib\Dict;

abstract class ObjectMap<Tk as arraykey, Tv> implements \HH\KeyedIterator<Tk, Tv>, \ArrayAccess<Tk, Tv>, \Countable {
    const classname<\Infinityloop\Utils\Exception\UnknownOffset> EXCEPTION_UNKNOWN_OFFSET =
        \Infinityloop\Utils\Exception\UnknownOffset::class;

    public function __construct(protected dict<Tk, Tv> $data = dict[]) {
        foreach ($data as $key => $object) {
            $this->offsetSet($key, $object);
        }
    }

    public function key(): Tk {
        return \key($this->data);
    }

    public function merge(ObjectMap<Tk, Tv> $objectSet, bool $allowReplace = false): this {
        foreach ($objectSet as $offset => $object) {
            if (!$allowReplace && $this->offsetExists($offset)) {
                throw new \Infinityloop\Utils\Exception\ItemAlreadyExists();
            }

            $this->offsetSet($offset, $object);
        }

        return $this;
    }

    public function toDic(): dict<arraykey, mixed> {
        return $this->data;
    }

    public function current(): Tv {
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

    public function offsetExists(Tk $offset): bool {
        return \array_key_exists($offset, $this->data);
    }

    public function offsetGet(Tk $offset): Tv {
        if (!$this->offsetExists($offset)) {
            $exception = static::EXCEPTION_UNKNOWN_OFFSET;

            throw new $exception($offset);
        }

        return $this->data[$offset];
    }

    public function offsetSet(Tk $offset, Tv $value): void {
        $this->data[$offset] = $value;
        return;
    }

    public function offsetUnset(Tk $offset): void {
        if (!$this->offsetExists($offset)) {
            $exception = static::EXCEPTION_UNKNOWN_OFFSET;

            throw new $exception((string)$offset);
        }

        $this->data = Dict\filter_with_key($this->data, ($key, $_) ==> $key !== $offset);
    }
}
