namespace Slack\GraphQL\__Private;

use namespace \Graphpinator\Parser;

/**
 * Visitor which composes many visitors and runs them on the AST.
 */
final class ParallelVisitor extends ASTVisitor {

    public function __construct(private vec<ASTVisitor> $visitors) {}

    <<__Override>>
    public function enter(nonnull $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->enter($node);
        }
    }

    <<__Override>>
    public function leave(nonnull $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->leave($node);
        }
    }

    <<__Override>>
    public function enterField(Parser\Field\Field $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->enterField($node);
        }
    }

    <<__Override>>
    public function leaveField(Parser\Field\Field $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->leaveField($node);
        }
    }

    <<__Override>>
    public function enterFieldSet(Parser\Field\FieldSet $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->enterFieldSet($node);
        }
    }

    <<__Override>>
    public function leaveFieldSet(Parser\Field\FieldSet $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->leaveFieldSet($node);
        }
    }

    <<__Override>>
    public function enterOperation(Parser\Operation\Operation $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->enterOperation($node);
        }
    }

    <<__Override>>
    public function leaveOperation(Parser\Operation\Operation $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->leaveOperation($node);
        }
    }

    <<__Override>>
    public function enterListTypeRef(Parser\TypeRef\ListTypeRef $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->enterListTypeRef($node);
        }
    }

    <<__Override>>
    public function leaveListTypeRef(Parser\TypeRef\ListTypeRef $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->leaveListTypeRef($node);
        }
    }

    <<__Override>>
    public function enterNamedTypeRef(Parser\TypeRef\NamedTypeRef $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->enterNamedTypeRef($node);
        }
    }

    <<__Override>>
    public function leaveNamedTypeRef(Parser\TypeRef\NamedTypeRef $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->leaveNamedTypeRef($node);
        }
    }

    <<__Override>>
    public function enterNotNullRef(Parser\TypeRef\NotNullRef $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->enterNotNullRef($node);
        }
    }

    <<__Override>>
    public function leaveNotNullRef(Parser\TypeRef\NotNullRef $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->leaveNotNullRef($node);
        }
    }

    <<__Override>>
    public function enterListVal(Parser\Value\ListVal $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->enterListVal($node);
        }
    }

    <<__Override>>
    public function leaveListVal(Parser\Value\ListVal $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->leaveListVal($node);
        }
    }

    <<__Override>>
    public function enterVariable(Parser\Variable\Variable $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->enterVariable($node);
        }
    }

    <<__Override>>
    public function leaveVariable(Parser\Variable\Variable $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->leaveVariable($node);
        }
    }
}
