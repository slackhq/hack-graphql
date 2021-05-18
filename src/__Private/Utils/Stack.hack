namespace Slack\GraphQL\__Private\Utils;

use namespace HH\Lib\Vec;

final class Stack<T> {
    private dict<int, T> $items = dict[];
    private int $length = 0;

    public function push(T $item): void {
        $this->items[$this->length] = $item;
        $this->length++;
    }

    public function pop(): T {
        $item = $this->items[$this->length - 1];
        $this->length--;
        return $item;
    }

    public function peek(): ?T {
        if ($this->length > 0) {
            return $this->items[$this->length - 1];
        }
        return null;
    }

    public function asVec(): vec<T> {
        return Vec\take($this->items, $this->length);
    }
}
