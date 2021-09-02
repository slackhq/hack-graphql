


namespace Graphpinator\Exception;

abstract class GraphpinatorBase extends \Exception implements \JsonSerializable {
    protected vec<string> $messageArgs = vec[];
    protected ?\Graphpinator\Common\Location $location = null;
    protected ?\Graphpinator\Common\Path $path = null;
    protected ?vec<string> $extensions = null;

    public function setLocation(\Graphpinator\Common\Location $location): this {
        $this->location = $location;

        return $this;
    }

    public function getLocation(): ?\Graphpinator\Common\Location {
        return $this->location;
    }

    public function setPath(\Graphpinator\Common\Path $path): this {
        $this->path = $path;

        return $this;
    }

    public function getPath(): ?\Graphpinator\Common\Path {
        return $this->path;
    }

    public function setExtensions(vec<string> $extensions): this {
        $this->extensions = $extensions;

        return $this;
    }

    public static function notOutputableResponse(): dict<string, string> {
        return dict[
            'message' => 'Server responded with unknown error.',
        ];
    }

    final public function jsonSerialize(): dict<string, mixed> {
        if (!$this->isOutputable()) {
            return self::notOutputableResponse();
        }

        $result = dict[
            'message' => $this->getMessage(),
        ];

        if ($this->location is \Graphpinator\Common\Location) {
            $result['locations'] = vec[$this->location];
        }

        if ($this->path is \Graphpinator\Common\Path) {
            $result['path'] = $this->path;
        }

        if ($this->extensions is nonnull) {
            $result['extensions'] = $this->extensions;
        }

        return $result;
    }

    public function isOutputable(): bool {
        return false;
    }
}
