


namespace Slack\GraphQL\__Private;

use namespace \Graphpinator\Parser;

/**
 * Visitor which composes many visitors and runs them on the AST.
 */
final class ParallelVisitor extends ASTVisitor {

    public function __construct(private vec<ASTVisitor> $visitors) {}

    <<__Override>>
    public function enter(Parser\Node $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->enter($node);
        }
    }

    <<__Override>>
    public function leave(Parser\Node $node): void {
        foreach ($this->visitors as $visitor) {
            $visitor->leave($node);
        }
    }
}
