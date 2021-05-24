namespace Graphpinator\Parser\Operation;

use namespace Graphpinator\Parser\Field;

final class Operation extends \Graphpinator\Parser\Node implements Field\IHasSelectionSet {

    private string $type;
    private string $name;
    private dict<string, \Graphpinator\Parser\Variable\Variable> $variables;
    private vec<\Graphpinator\Parser\Directive\Directive> $directives;
    private Field\SelectionSet $selectionSet;

    public function __construct(
        \Graphpinator\Common\Location $location,
        shape(
            'type' => string,
            'name' => string,
            ?'variables' => ?dict<string, \Graphpinator\Parser\Variable\Variable>,
            ?'directives' => ?vec<\Graphpinator\Parser\Directive\Directive>,
            'selection_set' => Field\SelectionSet,
        ) $args,
    ) {
        parent::__construct($location);
        $this->type = $args['type'];
        $this->name = $args['name'];
        $this->variables = $args['variables'] ?? dict[];
        $this->directives = $args['directives'] ?? vec[];
        $this->selectionSet = $args['selection_set'];
    }

    public function getType(): string {
        return $this->type;
    }

    public function getName(): string {
        return $this->name;
    }

    public function getSelectionSet(): Field\SelectionSet {
        return $this->selectionSet;
    }

    public function getVariables(): dict<string, \Graphpinator\Parser\Variable\Variable> {
        return $this->variables;
    }

    public function getDirectives(): vec<\Graphpinator\Parser\Directive\Directive> {
        return $this->directives;
    }
}
