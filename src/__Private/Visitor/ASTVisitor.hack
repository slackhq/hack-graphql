namespace Slack\GraphQL\__Private;

use namespace \Graphpinator\Parser;
use namespace Slack\GraphQL;

abstract class ASTVisitor {

    /**
     * Walk the provided AST, calling the appropriate enter and leave methods as we go.
     */
    final public function walk(Parser\ParsedRequest $request): void {
        $this->visitParsedRequest($request);
    }

    /**
     * Run this another visitor, then this visitor, in sequence on each node.
     */
    final public function runAfter(ASTVisitor $visitor): ASTVisitor {
        return new ParallelVisitor(vec[$visitor, $this]);
    }

    public function enter(Parser\Node $node): void {}

    public function leave(Parser\Node $node): void {}

    // Actual visitor implemention.

    final public function visitParsedRequest(Parser\ParsedRequest $node): void {
        $this->enter($node);
        foreach ($node->getOperations() as $operation) {
            $this->visitOperation($operation);
        }
        foreach ($node->getFragments() as $fragment) {
            $this->visitFragment($fragment);
        }
        $this->leave($node);
    }

    final public function visitField(Parser\Field\Field $node): void {
        $this->enter($node);
        $selection_set = $node->getSelectionSet();
        if ($selection_set) {
            $this->visitSelectionSet($selection_set);
        }
        foreach ($node->getArguments() ?? dict[] as $argument) {
            $this->visitArgument($argument);
        }
        foreach ($node->getDirectives() ?? vec[] as $directive) {
            // TODO: Directives
        }
        $this->leave($node);
    }

    final public function visitHasSelectionSet(Parser\Field\IHasSelectionSet $node): void {
        $this->enter($node);
        if ($node is Parser\Field\Field) {
            $this->visitField($node);
        } else if ($node is Parser\FragmentSpread\InlineFragmentSpread) {
            $this->visitFragmentSpread($node);
        } else if ($node is Parser\Fragment\Fragment) {
            $this->visitFragment($node);
        } else if ($node is Parser\Operation\Operation) {
            $this->visitOperation($node);
        }
        $this->leave($node);
    }

    final public function visitSelectionSet(Parser\Field\SelectionSet $node): void {
        $this->enter($node);
        foreach ($node->getItems() as $item) {
            if ($item is Parser\Field\Field) {
                $this->visitField($item);
            } else if ($item is Parser\FragmentSpread\FragmentSpread) {
                $this->visitFragmentSpread($item);
            }
        }
        $this->leave($node);
    }

    final public function visitOperation(Parser\Operation\Operation $node): void {
        $this->enter($node);
        $selection_set = $node->getSelectionSet();
        if ($selection_set) {
            $this->visitSelectionSet($selection_set);
        }
        foreach ($node->getDirectives() ?? vec[] as $directive) {
            // TODO: Directives
        }
        foreach ($node->getVariables() ?? vec[] as $variable) {
            $this->visitVariable($variable);
        }
        $this->leave($node);
    }

    final public function visitArgument(Parser\Value\ArgumentValue $node): void {
        $this->enter($node);
        $this->visitValue($node->getValue());
        $this->leave($node);
    }

    final public function visitValue(Parser\Value\Value $node): void {
        $this->enter($node);
        if ($node is Parser\Value\ListVal) {
            foreach ($node->getValue() as $value) {
                $this->visitValue($value);
            }
        } else if ($node is Parser\Value\ObjectVal) {
            foreach ($node->getValue() as $value) {
                $this->visitValue($value);
            }
        }
        $this->leave($node);
    }

    final public function visitVariable(Parser\Variable\Variable $node): void {
        $this->enter($node);
        $this->visitTypeRef($node->getType());
        foreach ($node->getDirectives() as $directive) {
            // TODO: Directives
        }
        $this->leave($node);
    }

    final public function visitTypeRef(Parser\TypeRef\TypeRef $node): void {
        $this->enter($node);
        if ($node is Parser\TypeRef\NotNullRef || $node is Parser\TypeRef\ListTypeRef) {
            $this->visitTypeRef($node->getInnerRef());
        }
        $this->leave($node);
    }

    final public function visitFragment(Parser\Fragment\Fragment $node): void {
        $this->enter($node);
        $this->visitSelectionSet($node->getSelectionSet());
        $this->visitTypeRef($node->getTypeCond());
        foreach ($node->getDirectives() as $directive) {
            // TODO: Directives
        }
        $this->leave($node);
    }

    final public function visitFragmentSpread(Parser\FragmentSpread\FragmentSpread $node): void {
        $this->enter($node);
        if ($node is Parser\FragmentSpread\NamedFragmentSpread) {
            $this->visitNamedFragmentSpread($node);
        } else if ($node is Parser\FragmentSpread\InlineFragmentSpread) {
            $this->visitInlineFragmentSpread($node);
        }
        $this->leave($node);
    }

    final public function visitNamedFragmentSpread(Parser\FragmentSpread\NamedFragmentSpread $node): void {
        $this->enter($node);
        foreach ($node->getDirectives() as $directive) {
            // TODO: Directives
        }
        $this->leave($node);
    }

    final public function visitInlineFragmentSpread(Parser\FragmentSpread\InlineFragmentSpread $node): void {
        $this->enter($node);
        $this->visitSelectionSet($node->getSelectionSet());
        $type_condition = $node->getTypeCond();
        if ($type_condition) {
            $this->visitTypeRef($type_condition);
        }
        foreach ($node->getDirectives() as $directive) {
            // TODO: Directives
        }
        $this->leave($node);
    }
}
