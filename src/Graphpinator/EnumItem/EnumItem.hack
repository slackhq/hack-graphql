namespace Graphpinator\EnumItem;

final class EnumItem implements \Graphpinator\Typesystem\Component {
    use \Graphpinator\Utils\TOptionalDescription;
    use \Graphpinator\Utils\THasDirectives;
    use \Graphpinator\Utils\TDeprecatable<\Graphpinator\Directive\Contract\EnumItemLocation>;

    private string $name;

    public function __construct(string $name, ?string $description = null) {
        $this->name = $name;
        $this->description = $description;
        $this->directiveUsages = new \Graphpinator\DirectiveUsage\DirectiveUsageSet();
    }

    public function getName(): string {
        return $this->name;
    }

    public function accept(\Graphpinator\Typesystem\ComponentVisitor $visitor): mixed {
        return $visitor->visitEnumItem($this);
    }

    public function addDirective(
        \Graphpinator\Directive\Contract\EnumItemLocation $directive,
        \Graphpinator\Argument\ArgumentSet $arguments = new \Graphpinator\Argument\ArgumentSet(),
    ): this {
        $this->directiveUsages
            ->offsetSet(null, new \Graphpinator\DirectiveUsage\DirectiveUsage($directive, $arguments));
        return $this;
    }
}
