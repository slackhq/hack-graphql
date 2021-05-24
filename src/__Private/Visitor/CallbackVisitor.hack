namespace Slack\GraphQL\__Private;

use namespace Graphpinator\Parser;

final class CallbackVisitor extends ASTVisitor {
    public function __construct(private (function(Parser\Node): void) $cb) {}

    <<__Override>>
    public function enter(Parser\Node $node): void {
        $cb = $this->cb;
        $cb($node);
    }
}
