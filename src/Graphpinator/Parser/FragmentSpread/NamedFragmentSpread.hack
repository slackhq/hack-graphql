namespace Graphpinator\Parser\FragmentSpread;

final class NamedFragmentSpread implements \Graphpinator\Parser\FragmentSpread\FragmentSpread {

    private string $name;
    private vec<\Graphpinator\Parser\Directive\Directive> $directives;

    public function __construct(string $name, ?vec<\Graphpinator\Parser\Directive\Directive> $directives = null) {
        $this->name = $name;
        $this->directives = $directives ?? vec[];
    }

    public function getName(): string {
        return $this->name;
    }

    public function getDirectives(): vec<\Graphpinator\Parser\Directive\Directive> {
        return $this->directives;
    }
}
