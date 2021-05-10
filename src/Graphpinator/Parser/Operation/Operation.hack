namespace Graphpinator\Parser\Operation;

final class Operation implements \Graphpinator\Parser\Field\IHasFieldSet {

    private string $type;
    private string $name;
    private dict<string, \Graphpinator\Parser\Variable\Variable> $variables;
    private vec<\Graphpinator\Parser\Directive\Directive> $directives;
    private \Graphpinator\Parser\Field\FieldSet $children;

    public function __construct(
        shape(
            'type' => string,
            'name' => string,
            ?'variables' => ?dict<string, \Graphpinator\Parser\Variable\Variable>,
            ?'directives' => ?vec<\Graphpinator\Parser\Directive\Directive>,
            'children' => \Graphpinator\Parser\Field\FieldSet,
        ) $args,
    ) {
        $this->type = $args['type'];
        $this->name = $args['name'];
        $this->variables = $args['variables'] ?? dict[];
        $this->directives = $args['directives'] ?? vec[];
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

    public function getVariables(): dict<string, \Graphpinator\Parser\Variable\Variable> {
        return $this->variables;
    }

    public function getDirectives(): vec<\Graphpinator\Parser\Directive\Directive> {
        return $this->directives;
    }
}
