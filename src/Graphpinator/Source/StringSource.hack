namespace Graphpinator\Source;

final class StringSource implements \Graphpinator\Source\Source<string> {

    private vec<string> $characters;
    private int $numberOfChars;
    private int $currentIndex = 0;
    private int $currentLine = 0;
    private int $currentColumn = 0;

    public function __construct(string $source) {
        $this->characters = vec(\preg_split('//u', $source, -1, \PREG_SPLIT_NO_EMPTY));
        $this->numberOfChars = \count($this->characters);
        $this->rewind();
    }

    public function hasChar(): bool {
        return \array_key_exists($this->currentIndex, $this->characters);
    }

    public function getChar(): string {
        if ($this->hasChar()) {
            return $this->characters[$this->currentIndex];
        }

        throw new \Graphpinator\Exception\Tokenizer\SourceUnexpectedEnd($this->getLocation());
    }

    public function getLocation(): \Graphpinator\Common\Location {
        return new \Graphpinator\Common\Location($this->currentLine, $this->currentColumn);
    }

    public function getNumberOfChars(): int {
        return $this->numberOfChars;
    }

    public function current(): string {
        return $this->getChar();
    }

    public function key(): int {
        return $this->currentIndex;
    }

    public function next(): void {
        if ($this->getChar() === \PHP_EOL) {
            ++$this->currentLine;
            $this->currentColumn = 1;
        } else {
            ++$this->currentColumn;
        }

        ++$this->currentIndex;
    }

    public function valid(): bool {
        return $this->hasChar();
    }

    public function rewind(): void {
        $this->currentIndex = 0;
        $this->currentLine = 1;
        $this->currentColumn = 1;
    }
}
