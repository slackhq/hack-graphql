namespace Slack\GraphQL\Validation;

use namespace HH\Lib\Str;
use type \Slack\GraphQL\__Private\ASTVisitor;

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
 *  enterField(\Graphpinator\Parser\Field\Field $field): void {
 *      // custom logic goes here
 *  }
 *
 * These methods will be called during AST traversal. To access
 * the schema node corresponding to the AST node, you can use
 * the `context` member of `ValidationRule`. E.g., if entering
 * a field, `$this->context->getType()` gets the corresponding
 * GQL type of that field, *if* the AST field node has a corresponding
 * node in the GQL schema.
 */
<<__ConsistentConstruct>>
abstract class ValidationRule extends ASTVisitor {
    public function __construct(protected ValidationContext $context) {}

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
