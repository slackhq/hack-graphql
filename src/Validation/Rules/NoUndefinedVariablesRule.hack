namespace Slack\GraphQL\Validation;

use namespace HH\Lib\C;
use type Slack\GraphQL\__Private\DependencyInfo;

final class NoUndefinedVariablesRule extends ValidationRule {
    <<__Override>>
    public function finalize(DependencyInfo $dependencies): void {
        foreach ($this->context->getAST()->getOperations() as $operation) {
            $variables = $operation->getVariables();
            foreach ($dependencies->getVariableUsages($operation) as $usage) {
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
