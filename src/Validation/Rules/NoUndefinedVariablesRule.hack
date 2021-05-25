namespace Slack\GraphQL\Validation;

use namespace Graphpinator\Parser;
use namespace HH\Lib\{C, Keyset, Vec};
use type Slack\GraphQL\__Private\Utils\Stack;

final class NoUndefinedVariablesRule extends ValidationRule {
    <<__Override>>
    public function leave(Parser\Node $node): void {
        if ($node is Parser\ParsedRequest) {
            foreach ($node->getOperations() as $operation) {
                $variables = $operation->getVariables();
                foreach ($this->context->getVariableUsages($operation) as $usage) {
                    if (!C\contains_key($variables, $usage->getVarName())) {
                        $operation_name = $operation->getName(); 
                        if ($operation_name) { 
                            $this->reportError(
                                $usage,
                                'Variable "$%s" is not defined by operation "%s".',
                                $usage->getVarName(),
                                $operation_name,
                            );
                        } else {
                            $this->reportError($usage, 'Variable "$%s" is not defined.', $usage->getVarName());
                        }
                    }
                }
            }
        }
    }
}
