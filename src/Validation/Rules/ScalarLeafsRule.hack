namespace Slack\GraphQL\Validation;


final class ScalarLeafsRule extends ValidationRule {
    <<__Override>>
    public function enterField(\Graphpinator\Parser\Field\Field $field): void {
        $named_type = $this->context->getType()?->getNamedType();
        $fieldset = $field->getFields();
        if ($named_type) {
            if ($named_type is \Slack\GraphQL\Types\LeafOutputType) {
                if ($fieldset) {
                    $this->context->addError(new \Slack\GraphQL\UserFacingError(
                        'Field "%s" must not have a selection since type "%s" has no subfields.',
                        $field->getName(),
                        $named_type->getName(),
                    ));
                }
            } elseif (!$fieldset) {
                $this->context->addError(new \Slack\GraphQL\UserFacingError(
                    'Field "%s" of type "%s" must have a selection of subfields.',
                    $field->getName(),
                    $named_type->getName() ?? \get_class($named_type),
                ));
            }
        }
    }
}
