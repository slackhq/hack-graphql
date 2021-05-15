namespace Slack\GraphQL\Validation;


final class FieldsOnCorrectTypeRule extends ValidationRule {
    <<__Override>>
    public function enterField(\Graphpinator\Parser\Field\Field $field): void {
        $type = $this->context->getParentType();
        if ($type) {
            $field_def = $this->context->getFieldDef();
            if (!$field_def) {
                // TODO: Suggestions
                $this->context->addError(new \Slack\GraphQL\UserFacingError(
                    'Cannot query field "%s" on type "%s".',
                    $field->getName(),
                    $type->getName(),
                ));
            }
        }
    }
}
