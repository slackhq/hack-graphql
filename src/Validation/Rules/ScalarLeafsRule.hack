namespace Slack\GraphQL\Validation;


final class ScalarLeafsRule extends ValidationRule {
    <<__Override>>
    public function enter(nonnull $node): void {
        if ($node is \Graphpinator\Parser\Field\Field) {
            $type = $this->context->getType()?->unwrapType();
            $fieldset = $node->getFields();
            if ($type) {
                if ($type is \Slack\GraphQL\Types\LeafOutputType) {
                    if ($fieldset) {
                        $this->reportError(
                            $node,
                            'Field "%s" must not have a selection since type "%s" has no subfields.',
                            $node->getName(),
                            $type->getName(),
                        );
                    }
                } elseif (!$fieldset) {
                    $this->reportError(
                        $node,
                        'Field "%s" of type "%s" must have a selection of subfields.',
                        $node->getName(),
                        $type->getName()
                    );
                }
            }
        }
    }
}
