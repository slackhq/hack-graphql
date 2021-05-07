namespace Graphpinator\Common;

final class Location implements \JsonSerializable {

    private int $line;
    private int $column;

    public function __construct(int $line, int $column) {
        $this->line = $line;
        $this->column = $column;
    }

    public function jsonSerialize(): dict<string, int> {
        return dict[
            'line' => $this->line,
            'column' => $this->column,
        ];
    }

    public function getLine(): int {
        return $this->line;
    }

    public function getColumn(): int {
        return $this->column;
    }
}
