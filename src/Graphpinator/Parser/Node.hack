
namespace Graphpinator\Parser;

abstract class Node implements \HH\IMemoizeParam {
    private static int $nextId = 0;
    private int $id;

    public function __construct(private \Graphpinator\Common\Location $location) {
        $this->id = self::$nextId;
        self::$nextId++;
    }

    final public function getId(): int {
        return $this->id;
    }

    final public function getLocation(): \Graphpinator\Common\Location {
        return $this->location;
    }

    final public function getInstanceKey(): string {
        return (string)$this->id;
    }
}
