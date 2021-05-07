namespace Graphpinator\Utils;

/**
 * Trait TDeprecatable which manages deprecated info for classes which support it.
 */
trait TDeprecatable<T> implements IAddDirectives<T> {
    protected \Graphpinator\DirectiveUsage\DirectiveUsageSet $directiveUsages;

    public function setDeprecated(?string $reason = null): this {
        $this->addDirective(
            \Graphpinator\Container\Container::directiveDeprecated(),
            new \Graphpinator\Argument\ArgumentSet(dict['reason' => $reason]),
        );

        return $this;
    }

    public function isDeprecated(): bool {
        foreach ($this->directiveUsages as $directive) {
            if ($directive->getDirective() is \Graphpinator\Directive\Spec\DeprecatedDirective) {
                return true;
            }
        }

        return false;
    }

    public function getDeprecationReason(): ?string {
        foreach ($this->directiveUsages as $directive) {
            if ($directive->getDirective() is \Graphpinator\Directive\Spec\DeprecatedDirective) {
                return (string)$directive->getArgumentValues()->offsetGet('reason')->getValue()->getRawValue();
            }
        }

        return null;
    }
}
