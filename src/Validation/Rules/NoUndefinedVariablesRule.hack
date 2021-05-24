namespace Slack\GraphQL\Validation;

use namespace Graphpinator\Parser;
use namespace HH\Lib\C;

final class NoUndefinedVariablesRule extends ValidationRule {
    private ?Parser\Operation\Operation $current_operation = null;
    private keyset<string> $variables = keyset[];

    <<__Override>>
    public function enter(Parser\Node $node): void {
        if ($node is Parser\Operation\Operation) {
            $this->current_operation = $node;
            $this->variables = keyset[];
        } elseif ($node is Parser\Variable\Variable) {
            $this->variables[] = $node->getName();
        }
    }

    <<__Override>>
    public function leave(Parser\Node $node): void {
        if ($node is Parser\Operation\Operation) {
            $usages = $this->context->getRecursiveVariableUsages($node);
            foreach ($usages as $usage) {
                $var_name = $usage['node']->getVarName();
                if (!C\contains_key($this->variables, $var_name)) {
                    $operation_name = $this->current_operation?->getName();
                    if ($operation_name) {
                        $this->reportError(
                            $usage['node'],
                            'Variable "$%s" is not defined by operation "%s".',
                            $var_name,
                            $operation_name,
                        );
                    } else {
                        $this->reportError($usage['node'], 'Variable "$%s" is not defined.', $var_name);
                    }
                }
            }
        }
    }
}
