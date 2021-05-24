namespace Graphpinator\Parser;

abstract class Node implements \HH\IMemoizeParam {
    public function __construct(
        private int $id,
        private \Graphpinator\Common\Location $location
    ) {}

    /**
     * Unique identifier for the node.
     */
    public function getId(): int {
        return $this->id;
    }

    public function getLocation(): \Graphpinator\Common\Location {
        return $this->location;
    }

    public function getInstanceKey(): string {
        return (string)$this->id;
    }
}

