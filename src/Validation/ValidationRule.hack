namespace Slack\GraphQL\Validation;

use namespace HH\Lib\Str;
use type \Slack\GraphQL\__Private\ASTVisitor;
use type \Slack\GraphQL\__Private\DependencyInfo;

/**
 * A validation rule which runs on the document AST.
 *
 * To implement your own rules, extend this class and register
 * your new class with `Validator`.
 *
 * Each `ValidationRule` specifies some set of AST nodes
 * on which to run custom validation. To do this, override the
 * `enter/leave` methods for those nodes. For example:
 *
 *  enter(\Graphpinator\Parser\Node $node): void {
 *      if ($node is \Graphpinator\Parser\Field) {
 *          // Run validation
 *      }
 *  }
 *
 * These methods will be called during AST traversal. To access
 * the schema node corresponding to the AST node, you can use
 * the `context` member of `ValidationRule`. E.g., if entering
 * a field, `$this->context->getType()` gets the corresponding
 * GQL type of that field, *if* the AST field node has a corresponding
 * node in the GQL schema.
 *
 * Lastly, you can override the `finalize()` method to run validation
 * which is only available after the entire AST has been visited.
 * The `finalize()` is passed info about all the dependencies of each
 * node, which is only available after traversal.
 */
<<__ConsistentConstruct>>
abstract class ValidationRule extends ASTVisitor {
    public function __construct(protected ValidationContext $context) {}

    public function finalize(DependencyInfo $dependencies): void {}

    final protected function assert(
        bool $condition,
        \Graphpinator\Parser\Node $node,
        Str\SprintfFormatString $message,
        mixed ...$args
    ): void {
        if (!$condition) {
            $this->reportError($node, '%s', \vsprintf($message, $args));
        }
    }

    final protected function reportError(
        \Graphpinator\Parser\Node $node,
        Str\SprintfFormatString $message,
        mixed ...$args
    ): void {
        $this->context->reportError($node, '%s', \vsprintf($message, $args));
    }
}
