namespace Graphpinator\Parser\Field;

use namespace HH\Lib\Dict;

final class Field extends \Graphpinator\Parser\Node implements IHasSelectionSet, ISelectionSetItem {

    public function __construct(
        \Graphpinator\Common\Location $location,
        private string $name,
        private ?string $alias = null,
        private ?SelectionSet $selectionSet = null,
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

    public function getSelectionSet(): ?SelectionSet {
        return $this->selectionSet;
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
