namespace Graphpinator\Parser\TypeRef;

final class NamedTypeRef extends \Graphpinator\Parser\TypeRef\TypeRef {

    public function __construct(int $id, \Graphpinator\Common\Location $location, private string $name) {
        parent::__construct($id, $location);
    }

    public function getName(): string {
        return $this->name;
    }

    public function print(): string {
        return $this->name;
    }
}
