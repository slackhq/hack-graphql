


namespace Slack\GraphQL\__Private;

use namespace HH\Lib\C;
use namespace Graphpinator\Parser;

final class DependencyInfo extends ASTVisitor {
    private ?Parser\Field\IHasSelectionSet $current_parent = null;

    private dict<string, Parser\Fragment\Fragment> $fragments = dict[];
    private dict<int, vec<Parser\Field\Field>> $fields = dict[];
    private dict<int, vec<Parser\FragmentSpread\NamedFragmentSpread>> $named_spreads = dict[];
    private dict<int, vec<Parser\Value\VariableRef>> $variables = dict[];

    <<__Override>>
    public function enter(Parser\Node $node): void {
        if ($node is Parser\Operation\Operation || $node is Parser\Fragment\Fragment) {
            $this->current_parent = $node;
            if ($node is Parser\Fragment\Fragment) {
                $this->fragments[$node->getName()] = $node;
            }
        } elseif ($node is Parser\FragmentSpread\NamedFragmentSpread) {
            $parent = $this->current_parent;
            if ($parent is nonnull) {
                $this->named_spreads[$parent->getId()] ??= vec[];
                $this->named_spreads[$parent->getId()][] = $node;
            }
        } elseif ($node is Parser\Value\VariableRef) {
            $parent = $this->current_parent;
            if ($parent is nonnull) {
                $this->variables[$parent->getId()] ??= vec[];
                $this->variables[$parent->getId()][] = $node;
            }
        }
    }

    <<__Override>>
    public function leave(Parser\Node $node): void {
        if ($node is Parser\Operation\Operation || $node is Parser\Fragment\Fragment) {
            $this->current_parent = null;
        }
    }

    // Set of nodes visited in the current call to `getReferencedFragments()` to prevent infinite recursion.
    private keyset<int> $visited = keyset[];

    <<__Memoize>>
    private function collectFragments(Parser\Field\IHasSelectionSet $parent): dict<string, Parser\Fragment\Fragment> {
        $fragments = dict[];
        if (C\contains_key($this->visited, $parent->getId())) {
            return $fragments;
        }
        $this->visited[] = $parent->getId();
        foreach ($this->named_spreads[$parent->getId()] ?? vec[] as $spread) {
            $fragment = $this->fragments[$spread->getName()] ?? null;
            if ($fragment) {
                $fragments[$fragment->getName()] = $fragment;
                foreach ($this->collectFragments($fragment) as $name => $frag) {
                    $fragments[$name] = $frag;
                }
            }
        }
        return $fragments;

    }

    <<__Memoize>>
    public function getReferencedFragments(
        Parser\Field\IHasSelectionSet $parent,
    ): dict<string, Parser\Fragment\Fragment> {
        $this->visited = keyset[];
        return $this->collectFragments($parent);
    }

    <<__Memoize>>
    public function getVariableUsages(Parser\Field\IHasSelectionSet $parent): vec<Parser\Value\VariableRef> {
        $usages = $this->variables[$parent->getId()] ?? vec[];
        foreach ($this->getReferencedFragments($parent) as $fragment) {
            foreach ($this->variables[$fragment->getId()] ?? vec[] as $usage) {
                $usages[] = $usage;
            }
        }
        return $usages;
    }
}
