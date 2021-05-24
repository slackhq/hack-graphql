namespace Slack\GraphQL\Validation;

use namespace Graphpinator\Parser;

final class NoUndefinedVariablesRule extends ValidationRule {
    private ?Parser\Operation\Operation $current_operation = null;
    private dict<string, Parser\Variable\Variable> $variables = dict[];

    <<__Override>>
    public function enter(Parser\Node $node): void {
        if ($node is Parser\Operation\Operation) {
            $this->current_operation = $node;
            $this->variables = $node->getVariables();
        } elseif ($node is Parser\Value\VariableRef) {
            $var_name = $node->getVarName();
            $variable = $this->variables[$var_name] ?? null;
            if (!$variable) {
                $operation_name = $this->current_operation?->getName();
                if ($operation_name) {
                    $this->reportError(
                        $node,
                        'Variable "$%s" is not defined by operation "%s".',
                        $var_name,
                        $operation_name,
                    );
                } else {
                    $this->reportError($node, 'Variable "$%s" is not defined.', $var_name);
                }
            }
        }
    }

    <<__Override>>
    public function leave(Parser\Node $node): void {
        if ($node is Parser\Operation\Operation) {
            $this->current_operation = null;
            $this->variables = dict[];
        }
    }
}
