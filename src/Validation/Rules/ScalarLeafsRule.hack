
namespace Slack\GraphQL\Validation;

final class ScalarLeafsRule extends ValidationRule {
    <<__Override>>
    public function enter(\Graphpinator\Parser\Node $node): void {
        if ($node is \Graphpinator\Parser\Field\Field) {
            $type = $this->context->getType()?->unwrapType();
            $selection_set = $node->getSelectionSet();
            if ($type) {
                if ($type is \Slack\GraphQL\Types\LeafType) {
                    $this->assert(
                        $selection_set is null,
                        $node,
                        'Field "%s" must not have a selection since type "%s" has no subfields.',
                        $node->getName(),
                        $type->getName(),
                    );
                } else {
                    $this->assert(
                        $selection_set is nonnull,
                        $node,
                        'Field "%s" of type "%s" must have a selection of subfields.',
                        $node->getName(),
                        $type->getName(),
                    );
                }
            }
        }
    }
}
