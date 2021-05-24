namespace Graphpinator\Parser\FragmentSpread;

use namespace Graphpinator\Parser\Field;

final class InlineFragmentSpread extends FragmentSpread implements Field\IHasSelectionSet {

    private vec<\Graphpinator\Parser\Directive\Directive> $directives;
    private ?\Graphpinator\Parser\TypeRef\NamedTypeRef $typeCond;

    public function __construct(
        int $id,
        \Graphpinator\Common\Location $location,
        private Field\SelectionSet $selectionSet,
        ?vec<\Graphpinator\Parser\Directive\Directive> $directives = null,
        ?\Graphpinator\Parser\TypeRef\NamedTypeRef $typeCond = null,
    ) {
        parent::__construct($id, $location);
        $this->directives = $directives ?? vec[];
        $this->typeCond = $typeCond;
    }

    public function getSelectionSet(): Field\SelectionSet {
        return $this->selectionSet;
    }

    public function getDirectives(): vec<\Graphpinator\Parser\Directive\Directive> {
        return $this->directives;
    }

    public function getTypeCond(): ?\Graphpinator\Parser\TypeRef\NamedTypeRef {
        return $this->typeCond;
    }
}
