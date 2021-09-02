
namespace Slack\GraphQL\Validation;

final class KnownArgumentNamesRule extends ValidationRule {
    <<__Override>>
    public function enter(\Graphpinator\Parser\Node $node): void {
        if ($node is \Graphpinator\Parser\Value\ArgumentValue) {
            // TODO: Handle directives
            $arg_def = $this->context->getArgument();
            $field_def = $this->context->getFieldDef();
            $parent_type = $this->context->getParentType();

            if ($arg_def is null && $field_def is nonnull && $parent_type is nonnull) {
                // TODO: Suggestions
                $this->reportError(
                    $node,
                    'Unknown argument "%s" on field "%s.%s".',
                    $node->getName(),
                    $parent_type->getName(),
                    $field_def->getName(),
                );
            }
        }
    }
}
