namespace Slack\GraphQL\Validation;


final class ScalarLeafsRule extends ValidationRule {
    <<__Override>>
    public function enter(\Graphpinator\Parser\Node $node): void {
        if ($node is \Graphpinator\Parser\Field\Field) {
            $type = $this->context->getType()?->unwrapType();
            $fieldset = $node->getFields();
            if ($type) {
                if ($type is \Slack\GraphQL\Types\LeafOutputType) {
                    $this->assert(
                        $fieldset is null,
                        $node,
                        'Field "%s" must not have a selection since type "%s" has no subfields.',
                        $node->getName(),
                        $type->getName(),
                    );
                } else {
                    $this->assert(
                        $fieldset is nonnull,
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
