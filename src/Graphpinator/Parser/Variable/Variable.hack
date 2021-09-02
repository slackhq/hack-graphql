
namespace Graphpinator\Parser\Variable;

final class Variable extends \Graphpinator\Parser\Node {

    public function __construct(
        \Graphpinator\Common\Location $location,
        private string $name,
        private \Graphpinator\Parser\TypeRef\TypeRef $type,
        private ?\Graphpinator\Parser\Value\Value $default,
        private vec<\Graphpinator\Parser\Directive\Directive> $directives,
    ) {
        parent::__construct($location);
    }

    public function getName(): string {
        return $this->name;
    }

    public function getType(): \Graphpinator\Parser\TypeRef\TypeRef {
        return $this->type;
    }

    public function getDefault(): ?\Graphpinator\Parser\Value\Value {
        return $this->default;
    }

    public function getDirectives(): vec<\Graphpinator\Parser\Directive\Directive> {
        return $this->directives;
    }
}
