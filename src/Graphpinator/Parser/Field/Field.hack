namespace Graphpinator\Parser\Field;

final class Field implements IHasFieldSet {

    public function __construct(
        private string $name,
        private ?string $alias = null,
        private ?\Graphpinator\Parser\Field\FieldSet $children = null,
        private ?dict<string, \Graphpinator\Parser\Value\ArgumentValue> $arguments = null,
        private ?vec<\Graphpinator\Parser\Directive\Directive> $directives = null,
    ) {}

    public function getName(): string {
        return $this->name;
    }

    public function getAlias(): ?string {
        return $this->alias;
    }

    public function getFields(): ?\Graphpinator\Parser\Field\FieldSet {
        return $this->children;
    }

    public function getArguments(): ?dict<string, \Graphpinator\Parser\Value\ArgumentValue> {
        return $this->arguments;
    }

    public function getDirectives(): ?vec<\Graphpinator\Parser\Directive\Directive> {
        return $this->directives;
    }
}
