namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

final class BooleanOutputType extends ScalarOutputType {
    const GraphQL\Introspection\__TypeKind TYPE_KIND = GraphQL\Introspection\__TypeKind::SCALAR;
    const type THackType = bool;
    const string NAME = 'Boolean';

    <<__Override>>
    protected function coerce(bool $value): bool {
        return $value;
    }
}
