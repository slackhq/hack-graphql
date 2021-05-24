namespace Graphpinator\Parser;


abstract class Node {
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
}

