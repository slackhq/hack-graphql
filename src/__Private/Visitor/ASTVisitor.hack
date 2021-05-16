namespace Slack\GraphQL\__Private;

use namespace \Graphpinator\Parser;

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

    private function visitParsedRequest(Parser\ParsedRequest $node): void {
        foreach ($node->getOperations() as $operation) {
            $this->visitOperation($operation);
        }
        foreach ($node->getFragments() as $fragment) {
            // TODO: Fragments
        }
    }

    private function visitField(Parser\Field\Field $node): void {
        $this->enter($node);
        $fieldset = $node->getFields();
        if ($fieldset) {
            $this->visitFieldSet($fieldset);
        }
        foreach ($node->getArguments() ?? dict[] as $argument) {
            $this->visitValue($argument);
        }
        foreach ($node->getDirectives() ?? vec[] as $directive) {
            // TODO: Directives
        }
        $this->leave($node);
    }

    private function visitFieldSet(Parser\Field\FieldSet $node): void {
        $this->enter($node);
        foreach ($node->getFields() as $field) {
            $this->visitField($field);
        }
        foreach ($node->getFragmentSpreads() as $fragment_spread) {
            // TODO: Fragments
        }
        $this->leave($node);
    }

    private function visitOperation(Parser\Operation\Operation $node): void {
        $this->enter($node);
        $fieldset = $node->getFields();
        if ($fieldset) {
            $this->visitFieldSet($fieldset);
        }
        foreach ($node->getDirectives() ?? vec[] as $directive) {
            // TODO: Directives
        }
        foreach ($node->getVariables() ?? vec[] as $variable) {
            $this->visitVariable($variable);
        }
        $this->leave($node);
    }

    private function visitValue(Parser\Value\Value $node): void {
        $this->enter($node);
        if ($node is Parser\Value\ListVal) {
            foreach ($node->getValue() as $value) {
                $this->visitValue($value);
            }
        } elseif ($node is Parser\Value\ObjectVal) {
            foreach ($node->getValue() as $value) {
                $this->visitValue($value);
            }
        }
        $this->leave($node);
    }

    private function visitVariable(Parser\Variable\Variable $node): void {
        $this->enter($node);
        foreach ($node->getDirectives() as $directive) {
            // TODO: Directives
        }
        $this->leave($node);
    }
}
