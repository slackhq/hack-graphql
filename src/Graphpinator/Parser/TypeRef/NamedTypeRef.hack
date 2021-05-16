namespace Graphpinator\Parser\TypeRef;

final class NamedTypeRef extends \Graphpinator\Parser\Node implements \Graphpinator\Parser\TypeRef\TypeRef {

    public function __construct(\Graphpinator\Common\Location $location, private string $name) {
        parent::__construct($location);
    }

    public function getName(): string {
        return $this->name;
    }

    public function print(): string {
        return $this->name;
    }
}
