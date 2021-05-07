namespace Graphpinator\Common;

use namespace HH\Lib\Vec;

final class Path implements \JsonSerializable {
    private vec<string> $path;

    public function __construct(vec<string> $path = vec[]) {
        $this->path = $path;
    }

    public function add(string $pathItem): this {
        $this->path[] = $pathItem;

        return $this;
    }

    public function pop(): this {
        $this->path = Vec\drop($this->path, 1);

        return $this;
    }

    public function jsonSerialize(): vec<string> {
        return $this->path;
    }
}
