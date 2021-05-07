namespace Graphpinator\Argument;

final class Argument implements \Graphpinator\Typesystem\Component {
    use \Graphpinator\Utils\TOptionalDescription;
    use \Graphpinator\Utils\THasDirectives;

    private ?\Graphpinator\Value\ArgumentValue $defaultValue = null;

    public function __construct(private string $name, private \Graphpinator\Type\Contract\Inputable $type) {
        $this->directiveUsages = new \Graphpinator\DirectiveUsage\DirectiveUsageSet();
    }

    public static function create(string $name, \Graphpinator\Type\Contract\Inputable $type): this {
        return new self($name, $type);
    }

    public function getName(): string {
        return $this->name;
    }

    public function getType(): \Graphpinator\Type\Contract\Inputable {
        return $this->type;
    }

    public function getDefaultValue(): ?\Graphpinator\Value\ArgumentValue {
        return $this->defaultValue;
    }

    public function setDefaultValue(mixed $defaultValue): this {
        $this->defaultValue = \Graphpinator\Value\ConvertRawValueVisitor::convertArgument(
            $this,
            $defaultValue,
            new \Graphpinator\Common\Path(),
        );

        return $this;
    }

    public function accept(\Graphpinator\Typesystem\ComponentVisitor $visitor): mixed {
        return $visitor->visitArgument($this);
    }

    public function addDirective(
        \Graphpinator\Directive\Contract\ArgumentDefinitionLocation $directive,
        \Graphpinator\Argument\ArgumentSet $arguments = new \Graphpinator\Argument\ArgumentSet(),
    ): this {
        $usage = new \Graphpinator\DirectiveUsage\DirectiveUsage($directive, $arguments);

        if (!$directive->validateArgumentUsage($this, $usage->getArgumentValues())) {
            throw new \Graphpinator\Exception\Type\DirectiveIncorrectType();
        }

        $this->directiveUsages->offsetSet(null, $usage);

        return $this;
    }
}
