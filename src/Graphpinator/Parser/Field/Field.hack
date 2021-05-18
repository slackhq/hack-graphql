namespace Graphpinator\Parser\Field;

use namespace HH\Lib\Dict;

final class Field extends \Graphpinator\Parser\Node implements IHasFieldSet {

    public function __construct(
        \Graphpinator\Common\Location $location,
        private string $name,
        private ?string $alias = null,
        private ?\Graphpinator\Parser\Field\FieldSet $children = null,
        private ?dict<string, \Graphpinator\Parser\Value\ArgumentValue> $arguments = null,
        private ?vec<\Graphpinator\Parser\Directive\Directive> $directives = null,
    ) {
        parent::__construct($location);
    }

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

    public function getArgumentValues(): dict<string, \Graphpinator\Parser\Value\Value> {
        return Dict\map($this->arguments ?? dict[], $arg ==> $arg->getValue());
    }

    public function getDirectives(): ?vec<\Graphpinator\Parser\Directive\Directive> {
        return $this->directives;
    }
}
