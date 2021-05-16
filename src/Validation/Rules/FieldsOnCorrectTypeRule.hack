namespace Slack\GraphQL\Validation;


final class FieldsOnCorrectTypeRule extends ValidationRule {
    <<__Override>>
    public function enter(\Graphpinator\Parser\Node $node): void {
        if ($node is \Graphpinator\Parser\Field\Field) {
            $type = $this->context->getParentType();
            if ($type) {
                $field_def = $this->context->getFieldDef();
                // TODO: Suggestions
                $this->assert(
                    $field_def is nonnull,
                    $node,
                    'Cannot query field "%s" on type "%s".',
                    $node->getName(),
                    $type->getName(),
                );
            }
        }
    }
}
