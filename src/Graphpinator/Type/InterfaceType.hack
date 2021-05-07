namespace Graphpinator\Type;

abstract class InterfaceType
    extends \Graphpinator\Type\Contract\AbstractDefinition
    implements \Graphpinator\Type\Contract\InterfaceImplementor {
    use \Graphpinator\Type\Contract\TInterfaceImplementor;
    use \Graphpinator\Type\Contract\TMetaFields;
    use \Graphpinator\Utils\THasDirectives;

    protected ?\Graphpinator\Field\FieldSet $fields = null;

    public function __construct(?\Graphpinator\Type\InterfaceSet $implements = null) {
        $this->implements = $implements ?? new \Graphpinator\Type\InterfaceSet();
        $this->directiveUsages = new \Graphpinator\DirectiveUsage\DirectiveUsageSet();
    }

    final public function isInstanceOf(\Graphpinator\Type\Contract\Definition $type): bool {
        if ($type is NotNullType) {
            return $this->isInstanceOf($type->getInnerType());
        }

        return \is_a($type, static::class) || ($type is this && $this->implements($type));
    }

    final public function isImplementedBy(\Graphpinator\Type\Contract\Definition $type): bool {
        if ($type is NotNullType) {
            return $this->isImplementedBy($type->getInnerType());
        }

        return $type is \Graphpinator\Type\Contract\InterfaceImplementor && $type->implements($this);
    }

    final public function getFields(): \Graphpinator\Field\FieldSet {
        if ($this->fields is null) {
            $this->fields = new \Graphpinator\Field\FieldSet();

            foreach ($this->implements as $interfaceType) {
                $this->fields->merge($interfaceType->getFields(), true);
            }

            $this->fields->merge($this->getFieldDefinition(), true);

            if (\Graphpinator\Graphpinator::$validateSchema) {
                $this->validateInterfaceContract();
            }
        }

        return $this->fields as \Graphpinator\Field\FieldSet;
    }

    final public function accept(\Graphpinator\Typesystem\NamedTypeVisitor $visitor): mixed {
        return $visitor->visitInterface($this);
    }

    final public function addDirective(
        \Graphpinator\Directive\Contract\ObjectLocation $directive,
        \Graphpinator\Argument\ArgumentSet $arguments = new \Graphpinator\Argument\ArgumentSet(),
    ): this {
        $usage = new \Graphpinator\DirectiveUsage\DirectiveUsage($directive, $arguments);

        if (!$directive->validateObjectUsage($this, $usage->getArgumentValues())) {
            throw new \Graphpinator\Exception\Type\DirectiveIncorrectType();
        }

        $this->directiveUsages->offsetSet(null, $usage);

        return $this;
    }

    abstract protected function getFieldDefinition(): \Graphpinator\Field\FieldSet;
}
