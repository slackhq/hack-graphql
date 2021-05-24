namespace Slack\GraphQL\Validation;

use namespace Graphpinator\Parser;
use namespace HH\Lib\{C, Keyset, Vec};
use type Slack\GraphQL\__Private\Utils\Stack;

final class NoUndefinedVariablesRule extends ValidationRule {
    private ?Parser\Operation\Operation $current_operation = null;
    private ?Parser\Fragment\Fragment $current_fragment = null;

    private dict<int, vec<Parser\FragmentSpread\NamedFragmentSpread>> $operation_to_named_spread = dict[];
    private dict<int, vec<Parser\FragmentSpread\NamedFragmentSpread>> $fragment_to_named_spread = dict[];

    private dict<int, vec<Parser\Value\VariableRef>> $operation_to_variables = dict[];
    private dict<int, vec<Parser\Value\VariableRef>> $fragment_to_variables = dict[];

    <<__Override>>
    public function enter(Parser\Node $node): void {
        if ($node is Parser\Operation\Operation) {
            $this->current_operation = $node;
        } elseif ($node is Parser\Fragment\Fragment) {
            $this->current_fragment = $node;
        } elseif ($node is Parser\Value\VariableRef) {
            if ($this->current_operation) {
                $op_id = $this->current_operation->getId();
                $this->operation_to_variables[$op_id] ??= vec[];
                $this->operation_to_variables[$op_id][] = $node;
            } elseif ($this->current_fragment) {
                $frag_id = $this->current_fragment->getId();
                $this->fragment_to_variables[$frag_id] ??= vec[];
                $this->fragment_to_variables[$frag_id][] = $node;
            }
        } elseif ($node is Parser\FragmentSpread\NamedFragmentSpread) {
            if ($this->current_operation) {
                $op_id = $this->current_operation->getId();
                $this->operation_to_named_spread[$op_id] ??= vec[];
                $this->operation_to_named_spread[$op_id][] = $node;
            } elseif ($this->current_fragment) {
                $frag_id = $this->current_fragment->getId();
                $this->fragment_to_named_spread[$frag_id] ??= vec[];
                $this->fragment_to_named_spread[$frag_id][] = $node;
            }
        }
    }

    <<__Override>>
    public function leave(Parser\Node $node): void {
        if ($node is Parser\Operation\Operation) {
            $this->current_operation = null;
        } elseif ($node is Parser\Fragment\Fragment) {
            $this->current_fragment = null;
        } elseif ($node is Parser\ParsedRequest) {
            foreach ($node->getOperations() as $operation) {
                // For each operation, get all the variable refs it includes,
                // accounting for referenced named fragments
                $usages = $this->operation_to_variables[$operation->getId()] ?? vec[];
                $named_fragments = new Stack($this->operation_to_named_spread[$operation->getId()] ?? vec[]);
                $visited = keyset[];
                while ($named_fragments->length() > 0) {
                    $curr_fragment = $named_fragments->pop();
                    if (!C\contains_key($visited, $curr_fragment->getId())) {
                        $visited[] = $curr_fragment->getId();
                        $usages = Vec\concat($usages, $this->fragment_to_variables[$curr_fragment->getId()] ?? vec[]);
                        foreach ($this->fragment_to_named_spread[$curr_fragment->getId()] ?? vec[] as $frag) {
                            $named_fragments->push($frag);
                        }
                    }
                }

                $variables = $operation->getVariables();
                foreach ($usages as $usage) {
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
