namespace Graphpinator\Parser;


abstract class Node {
    public function __construct(private \Graphpinator\Common\Location $location) {}

    public function getLocation(): \Graphpinator\Common\Location {
        return $this->location;
    }
}

