namespace Graphpinator\Directive;

abstract class Directive implements \Graphpinator\Directive\Contract\Definition {

    const NAME = '';
    const ?string DESCRIPTION = null;
    const REPEATABLE = false;

    protected ?\Graphpinator\Argument\ArgumentSet $arguments = null;

    final public function getName(): string {
        return static::NAME;
    }

    final public function getDescription(): ?string {
        return static::DESCRIPTION;
    }

    final public function getLocations(): vec<string> {
        $locations = vec[];
        $reflection = new \ReflectionClass($this);

        foreach ($reflection->getInterfaces() as $interface) {
            if (\array_key_exists($interface->getName(), self::INTERFACE_TO_LOCATION)) {
                /* HH_FIXME[4324] */
                $locations = \array_merge($locations, self::INTERFACE_TO_LOCATION[$interface->getName()]);
            }
        }

        return $locations;
    }

    final public function isRepeatable(): bool {
        return static::REPEATABLE;
    }

    final public function getArguments(): \Graphpinator\Argument\ArgumentSet {
        if ($this->arguments is null) {
            $this->arguments = $this->getFieldDefinition();
            $this->afterGetFieldDefinition();
        }

        return $this->arguments as \Graphpinator\Argument\ArgumentSet;
    }

    final public function accept(\Graphpinator\Typesystem\EntityVisitor $visitor): mixed {
        return $visitor->visitDirective($this);
    }

    abstract protected function getFieldDefinition(): \Graphpinator\Argument\ArgumentSet;

    /**
     * This function serves to prevent infinite cycles.
     *
     * It doesn't have to be used at all, unless directive have arguments with directive cycles.
     * Eg. IntConstraintDirective::oneOf -> ListConstraintDirective::minItems -> IntConstraintDirective::oneOf.
     */
    protected function afterGetFieldDefinition(): void {
    }
}
