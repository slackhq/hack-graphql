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

    // Actual visitor implemention.
    //
    // TODO: Is there a better way to enforce that each node be visitable?
    // Maybe we should force all Graphphinator Parsed AST nodes to implement
    // an `accept` method and move this logic there?

    private function visitParsedRequest(Parser\ParsedRequest $node): void {
        foreach ($node->getOperations() as $operation) {
            $this->visitOperation($operation);
        }
        foreach ($node->getFragments() as $fragment) {
            // TODO: Fragments
        }
    }

    private function visitField(Parser\Field\Field $node): void {
        $this->enterField($node);
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
        $this->leaveField($node);
    }

    private function visitFieldSet(Parser\Field\FieldSet $node): void {
        $this->enterFieldSet($node);
        foreach ($node->getFields() as $field) {
            $this->visitField($field);
        }
        foreach ($node->getFragmentSpreads() as $fragment_spread) {
            // TODO: Fragments
        }
        $this->leaveFieldSet($node);
    }

    private function visitOperation(Parser\Operation\Operation $node): void {
        $this->enterOperation($node);
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
        $this->leaveOperation($node);
    }

    private function visitTypeRef(Parser\TypeRef\TypeRef $node): void {
        if ($node is Parser\TypeRef\ListTypeRef) {
            $this->visitListTypeRef($node);
        } elseif ($node is Parser\TypeRef\NotNullRef) {
            $this->visitNotNullRef($node);
        } elseif ($node is Parser\TypeRef\NamedTypeRef) {
            $this->visitNamedTypeRef($node);
        } else {
            throw new \Exception("Unrecognized type ref: ".\get_class($node));
        }
    }

    private function visitListTypeRef(Parser\TypeRef\ListTypeRef $node): void {
        $this->enterListTypeRef($node);
        $this->visitTypeRef($node->getInnerRef());
        $this->leaveListTypeRef($node);
    }

    private function visitNamedTypeRef(Parser\TypeRef\NamedTypeRef $node): void {
        $this->enterNamedTypeRef($node);
        $this->leaveNamedTypeRef($node);
    }

    private function visitNotNullRef(Parser\TypeRef\NotNullRef $node): void {
        $this->enterNotNullRef($node);
        $this->visitTypeRef($node->getInnerRef());
        $this->leaveNotNullRef($node);
    }

    private function visitValue(Parser\Value\Value $node): void {
        if ($node is Parser\Value\EnumLiteral) {
            $this->visitEnumLiteral($node);
        } elseif ($node is Parser\Value\Literal) {
            $this->visitLiteral($node);
        } elseif ($node is Parser\Value\ObjectVal) {
            $this->visitObjectVal($node);
        } elseif ($node is Parser\Value\VariableRef) {
            $this->visitVariableRef($node);
        } else {
            throw new \Exception("Unrecognized value: ".\get_class($node));
        }
    }

    private function visitListVal(Parser\Value\ListVal $node): void {
        $this->enterListVal($node);
        foreach ($node->getValue() as $value) {
            $this->visitValue($value);
        }
        $this->leaveListVal($node);
    }

    private function visitObjectVal(Parser\Value\ObjectVal $node): void {
        $this->enterObjectVal($node);
        foreach ($node->getValue() as $value) {
            $this->visitValue($value);
        }
        $this->leaveObjectValue($node);
    }

    private function visitEnumLiteral(Parser\Value\EnumLiteral $node): void {
        $this->enterEnumLiteral($node);
        $this->leaveEnumLiteral($node);
    }

    private function visitLiteral(Parser\Value\Literal $node): void {
        $this->enterLiteral($node);
        $this->leaveLiteral($node);
    }

    private function visitVariableRef(Parser\Value\VariableRef $node): void {
        $this->enterVariableRef($node);
        $this->leaveVariableRef($node);
    }

    private function visitVariable(Parser\Variable\Variable $node): void {
        $this->enterVariable($node);
        foreach ($node->getDirectives() as $directive) {
            // TODO: Directives
        }
        $this->leaveVariable($node);
    }

    //
    // Enter / Leave methods. Override these to do stuff.
    //

    public function enter(nonnull $node): void {}

    public function leave(nonnull $node): void {}

    public function enterField(Parser\Field\Field $node): void {
        $this->enter($node);
    }

    public function leaveField(Parser\Field\Field $node): void {
        $this->leave($node);
    }

    public function enterFieldSet(Parser\Field\FieldSet $node): void {
        $this->enter($node);
    }

    public function leaveFieldSet(Parser\Field\FieldSet $node): void {
        $this->leave($node);
    }

    public function enterOperation(Parser\Operation\Operation $node): void {
        $this->enter($node);
    }

    public function leaveOperation(Parser\Operation\Operation $node): void {
        $this->leave($node);
    }

    public function enterListTypeRef(Parser\TypeRef\ListTypeRef $node): void {
        $this->enter($node);
    }

    public function leaveListTypeRef(Parser\TypeRef\ListTypeRef $node): void {
        $this->leave($node);
    }

    public function enterNamedTypeRef(Parser\TypeRef\NamedTypeRef $node): void {
        $this->enter($node);
    }

    public function leaveNamedTypeRef(Parser\TypeRef\NamedTypeRef $node): void {
        $this->leave($node);
    }

    public function enterNotNullRef(Parser\TypeRef\NotNullRef $node): void {
        $this->enter($node);
    }

    public function leaveNotNullRef(Parser\TypeRef\NotNullRef $node): void {
        $this->leave($node);
    }

    public function enterEnumLiteral(Parser\Value\EnumLiteral $node): void {
        $this->enter($node);
    }

    public function leaveEnumLiteral(Parser\Value\EnumLiteral $node): void {
        $this->leave($node);
    }

    public function enterLiteral(Parser\Value\Literal $node): void {
        $this->enter($node);
    }

    public function leaveLiteral(Parser\Value\Literal $node): void {
        $this->leave($node);
    }

    public function enterVariableRef(Parser\Value\VariableRef $node): void {
        $this->enter($node);
    }

    public function leaveVariableRef(Parser\Value\VariableRef $node): void {
        $this->leave($node);
    }

    public function enterListVal(Parser\Value\ListVal $node): void {
        $this->enter($node);
    }

    public function leaveListVal(Parser\Value\ListVal $node): void {
        $this->leave($node);
    }

    public function enterObjectVal(Parser\Value\ObjectVal $node): void {
        $this->enter($node);
    }

    public function leaveObjectValue(Parser\Value\ObjectVal $node): void {
        $this->leave($node);
    }

    public function enterVariable(Parser\Variable\Variable $node): void {
        $this->enter($node);
    }

    public function leaveVariable(Parser\Variable\Variable $node): void {
        $this->leave($node);
    }
}
