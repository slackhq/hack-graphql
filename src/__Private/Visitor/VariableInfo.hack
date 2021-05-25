namespace Slack\GraphQL\__Private;

use namespace Graphpinator\Parser;

final class VariableInfo extends ASTVisitor {
    private ?Parser\Operation\Operation $current_operation = null;
    private ?Parser\Fragment\Fragment $current_fragment = null;

    private dict<int, vec<Parser\Value\VariableRef>> $operation_to_variables = dict[];
    private dict<int, vec<Parser\Value\VariableRef>> $fragment_to_variables = dict[];

    public function __construct(private FragmentInfo $fragment_info) {}

    <<__Memoize>>
    public function getVariableUsages(Parser\Operation\Operation $operation): vec<Parser\Value\VariableRef> {
        $usages = $this->operation_to_variables[$operation->getId()] ?? vec[];
        $fragments = $this->fragment_info->getFragments($operation);
        foreach ($fragments as $fragment) {
            foreach ($this->fragment_to_variables[$fragment->getId()] ?? vec[] as $usage) {
                $usages[] = $usage; 
            } 
        }
        return $usages;
    }

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
        }
    }

    <<__Override>>
    public function leave(Parser\Node $node): void {
        if ($node is Parser\Operation\Operation) {
            $this->current_operation = null;
        } elseif ($node is Parser\Fragment\Fragment) {
            $this->current_fragment = null;
        }
    }
}
