namespace Graphpinator\Parser\Directive;

final class Directive {

    public function __construct(
        private string $name,
        private ?dict<string, \Graphpinator\Parser\Value\ArgumentValue> $arguments,
    ) {}

    public function getName(): string {
        return $this->name;
    }

    public function getArguments(): ?dict<string, \Graphpinator\Parser\Value\ArgumentValue> {
        return $this->arguments;
    }
}
