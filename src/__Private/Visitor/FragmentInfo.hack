namespace Slack\GraphQL\__Private;

use namespace HH\Lib\C;
use namespace Graphpinator\Parser;
use type \Slack\GraphQL\__Private\Utils\Stack;

final class FragmentInfo extends ASTVisitor {
    private ?Parser\Operation\Operation $current_operation = null;
    private ?Parser\Fragment\Fragment $current_fragment = null;

    private dict<string, Parser\Fragment\Fragment> $fragments = dict[];
    private dict<int, vec<Parser\FragmentSpread\NamedFragmentSpread>> $operation_to_named_spread = dict[];
    private dict<int, vec<Parser\FragmentSpread\NamedFragmentSpread>> $fragment_to_named_spread = dict[];

    <<__Memoize>>
    public function getFragments(Parser\Operation\Operation $operation): dict<string, Parser\Fragment\Fragment> {
        $fragments = dict[];
        $stack = new Stack($this->operation_to_named_spread[$operation->getId()] ?? vec[]);
        while ($stack->length() > 0) {
            $fragment = $this->fragments[$stack->pop()->getName()] ?? null;
            if ($fragment && !C\contains_key($fragments, $fragment->getName())) {
                $fragments[$fragment->getName()] = $fragment;
                foreach ($this->fragment_to_named_spread[$fragment->getId()] ?? vec[] as $frag) {
                    $stack->push($frag);
                }
            }
        }
        return $fragments;
    }

    <<__Override>>
    public function enter(Parser\Node $node): void {
        if ($node is Parser\Operation\Operation) {
            $this->current_operation = $node;
        } elseif ($node is Parser\Fragment\Fragment) {
            $this->current_fragment = $node;
            $this->fragments[$node->getName()] = $node;
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
        }
    }
}