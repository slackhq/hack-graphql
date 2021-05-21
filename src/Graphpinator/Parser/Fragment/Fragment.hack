namespace Graphpinator\Parser\Fragment;

use namespace Graphpinator\Parser\Field;

final class Fragment extends \Graphpinator\Parser\Node implements Field\IHasSelectionSet {

    public function __construct(
        \Graphpinator\Common\Location $location,
        private string $name,
        private \Graphpinator\Parser\TypeRef\NamedTypeRef $typeCond,
        private vec<\Graphpinator\Parser\Directive\Directive> $directives,
        private Field\SelectionSet $selectionSet,
    ) {
        parent::__construct($location);
    }

    public function getName(): string {
        return $this->name;
    }

    public function getSelectionSet(): Field\SelectionSet {
        return $this->selectionSet;
    }

    public function getTypeCond(): \Graphpinator\Parser\TypeRef\NamedTypeRef {
        return $this->typeCond;
    }

    public function getDirectives(): vec<\Graphpinator\Parser\Directive\Directive> {
        return $this->directives;
    }
}
