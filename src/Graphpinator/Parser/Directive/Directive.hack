
namespace Graphpinator\Parser\Directive;

final class Directive extends \Graphpinator\Parser\Node {

    public function __construct(
        \Graphpinator\Common\Location $location,
        private string $name,
        private ?dict<string, \Graphpinator\Parser\Value\ArgumentValue> $arguments,
    ) {
        parent::__construct($location);
    }

    public function getName(): string {
        return $this->name;
    }

    public function getArguments(): ?dict<string, \Graphpinator\Parser\Value\ArgumentValue> {
        return $this->arguments;
    }
}
