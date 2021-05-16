namespace Graphpinator\Parser\FragmentSpread;

final class InlineFragmentSpread
    extends \Graphpinator\Parser\Node
    implements \Graphpinator\Parser\FragmentSpread\FragmentSpread {

    private \Graphpinator\Parser\Field\FieldSet $fields;
    private vec<\Graphpinator\Parser\Directive\Directive> $directives;
    private ?\Graphpinator\Parser\TypeRef\NamedTypeRef $typeCond;

    public function __construct(
        \Graphpinator\Common\Location $location,
        \Graphpinator\Parser\Field\FieldSet $fields,
        ?vec<\Graphpinator\Parser\Directive\Directive> $directives = null,
        ?\Graphpinator\Parser\TypeRef\NamedTypeRef $typeCond = null,
    ) {
        parent::__construct($location);
        $this->fields = $fields;
        $this->directives = $directives ?? vec[];
        $this->typeCond = $typeCond;
    }

    public function getFields(): \Graphpinator\Parser\Field\FieldSet {
        return $this->fields;
    }

    public function getDirectives(): vec<\Graphpinator\Parser\Directive\Directive> {
        return $this->directives;
    }

    public function getTypeCond(): ?\Graphpinator\Parser\TypeRef\NamedTypeRef {
        return $this->typeCond;
    }
}
