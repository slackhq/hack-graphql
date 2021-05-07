namespace Graphpinator\Parser\Operation;

final class Operation {

    private string $type;
    private string $name;
    private \Graphpinator\Parser\Variable\VariableSet $variables;
    private \Graphpinator\Parser\Directive\DirectiveSet $directives;
    private \Graphpinator\Parser\Field\FieldSet $children;

    public function __construct(
        shape(
            'type' => string,
            'name' => string,
            ?'variables' => ?\Graphpinator\Parser\Variable\VariableSet,
            ?'directives' => ?\Graphpinator\Parser\Directive\DirectiveSet,
            'children' => \Graphpinator\Parser\Field\FieldSet,
        ) $args,
    ) {
        $this->type = $args['type'];
        $this->name = $args['name'];
        $this->variables = $args['variables'] ?? new \Graphpinator\Parser\Variable\VariableSet();
        $this->directives = $args['directives'] ?? new \Graphpinator\Parser\Directive\DirectiveSet();
        $this->children = $args['children'];
    }

    public function getType(): string {
        return $this->type;
    }

    public function getName(): string {
        return $this->name;
    }

    public function getFields(): \Graphpinator\Parser\Field\FieldSet {
        return $this->children;
    }

    public function getVariables(): \Graphpinator\Parser\Variable\VariableSet {
        return $this->variables;
    }

    public function getDirectives(): \Graphpinator\Parser\Directive\DirectiveSet {
        return $this->directives;
    }
}
