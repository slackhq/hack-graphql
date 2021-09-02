
namespace Slack\GraphQL\Validation;

final class KnownTypeNamesRule extends ValidationRule {
    <<__Override>>
    public function enter(\Graphpinator\Parser\Node $node): void {
        if ($node is \Graphpinator\Parser\TypeRef\NamedTypeRef) {
            $type = $this->context->getSchema()->getIntrospectionType($node->getName());
            if ($type is null) {
                $this->reportError($node, 'Unknown type "%s".', $node->getName());
            }
        }
    }
}
