namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL;

final class StringOutputType extends ScalarOutputType {
    const type THackType = string;
    const GraphQL\Introspection\__TypeKind TYPE_KIND = GraphQL\Introspection\__TypeKind::SCALAR;
    const string NAME = 'String';

    <<__Override>>
    protected function coerce(string $value): string {
        return $value;
    }
}
