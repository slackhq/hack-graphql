
namespace Graphpinator\Parser\FragmentSpread;

final class NamedFragmentSpread
    extends \Graphpinator\Parser\Node
    implements \Graphpinator\Parser\FragmentSpread\FragmentSpread {

    private string $name;
    private vec<\Graphpinator\Parser\Directive\Directive> $directives;

    public function __construct(
        \Graphpinator\Common\Location $location,
        string $name,
        ?vec<\Graphpinator\Parser\Directive\Directive> $directives = null,
    ) {
        parent::__construct($location);
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
