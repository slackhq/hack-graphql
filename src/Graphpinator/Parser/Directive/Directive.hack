namespace Graphpinator\Parser\Directive;

final class Directive {

    public function __construct(
        private string $name,
        private ?\Graphpinator\Parser\Value\ArgumentValueSet $arguments,
    ) {}

    public function getName(): string {
        return $this->name;
    }

    public function getArguments(): ?\Graphpinator\Parser\Value\ArgumentValueSet {
        return $this->arguments;
    }
}
