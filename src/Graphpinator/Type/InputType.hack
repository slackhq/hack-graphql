namespace Graphpinator\Type;

abstract class InputType
    extends \Graphpinator\Type\Contract\ConcreteDefinition
    implements \Graphpinator\Type\Contract\Inputable {
    use \Graphpinator\Utils\THasDirectives;

    protected \Graphpinator\Argument\ArgumentSet $arguments;
    private bool $cycleValidated = false;

    public function __construct() {
        $this->directiveUsages = new \Graphpinator\DirectiveUsage\DirectiveUsageSet();
        $this->arguments = new \Graphpinator\Argument\ArgumentSet();
    }

    final public function getArguments(): \Graphpinator\Argument\ArgumentSet {
        if (!$this->arguments is \Graphpinator\Argument\ArgumentSet) {
            $this->arguments = $this->getFieldDefinition();
            $this->afterGetFieldDefinition();

            if (\Graphpinator\Graphpinator::$validateSchema) {
                $this->validateCycles(dict[]);
            }
        }

        return $this->arguments;
    }

    final public function accept(\Graphpinator\Typesystem\NamedTypeVisitor $visitor): mixed {
        return $visitor->visitInput($this);
    }

    final public function addDirective(
        \Graphpinator\Directive\Contract\InputObjectLocation $directive,
        \Graphpinator\Argument\ArgumentSet $arguments = new \Graphpinator\Argument\ArgumentSet(),
    ): this {
        $usage = new \Graphpinator\DirectiveUsage\DirectiveUsage($directive, $arguments);

        if (!$directive->validateInputUsage($this, $usage->getArgumentValues())) {
            throw new \Graphpinator\Exception\Type\DirectiveIncorrectType();
        }

        $this->directiveUsages->offsetSet(null, $usage);

        return $this;
    }

    abstract protected function getFieldDefinition(): \Graphpinator\Argument\ArgumentSet;

    /**
     * This function serves to prevent infinite cycles.
     *
     * It doesn't have to be used at all, unless input have arguments self referencing fields and wish to put default value for them.
     */
    protected function afterGetFieldDefinition(): void {
    }

    private function validateCycles(dict<string, bool> $stack): void {
        if ($this->cycleValidated) {
            return;
        }

        if (\array_key_exists($this->getName(), $stack)) {
            throw new \Graphpinator\Exception\Type\InputCycle();
        }

        $stack[$this->getName()] = true;

        foreach (($this->arguments ?? new \Graphpinator\Argument\ArgumentSet()) as $argumentContract) {
            $type = $argumentContract->getType();

            if (!$type is NotNullType) {
                continue;
            }

            $type = $type->getInnerType();

            if (!$type is InputType) {
                continue;
            }

            if ($type->arguments === null) {
                $type->arguments = $type->getFieldDefinition();
            }

            $type->validateCycles($stack);
        }

        unset($stack[$this->getName()]);
        $this->cycleValidated = true;
    }
}
