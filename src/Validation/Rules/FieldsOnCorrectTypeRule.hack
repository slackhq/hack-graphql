namespace Slack\GraphQL\Validation;


final class FieldsOnCorrectTypeRule extends ValidationRule {
    <<__Override>>
    public function enter(nonnull $node): void {
        if ($node is \Graphpinator\Parser\Field\Field) {
            $type = $this->context->getParentType();
            if ($type) {
                $field_def = $this->context->getFieldDef();
                if (!$field_def) {
                    // TODO: Suggestions
                    $this->reportError(
                        $node,
                        'Cannot query field "%s" on type "%s".',
                        $node->getName(),
                        $type->getName(),
                    );
                }
            }
        }
    }
}
