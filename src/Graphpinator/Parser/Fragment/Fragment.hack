namespace Graphpinator\Parser\Fragment;

final class Fragment {

    public function __construct(
        private string $name,
        private \Graphpinator\Parser\TypeRef\NamedTypeRef $typeCond,
        private vec<\Graphpinator\Parser\Directive\Directive> $directives,
        private \Graphpinator\Parser\Field\FieldSet $fields,
    ) {}

    public function getName(): string {
        return $this->name;
    }

    public function getFields(): \Graphpinator\Parser\Field\FieldSet {
        return $this->fields;
    }

    public function getTypeCond(): \Graphpinator\Parser\TypeRef\NamedTypeRef {
        return $this->typeCond;
    }

    public function getDirectives(): vec<\Graphpinator\Parser\Directive\Directive> {
        return $this->directives;
    }
}
