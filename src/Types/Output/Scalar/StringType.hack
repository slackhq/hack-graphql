namespace Slack\GraphQL\Types;

final class StringOutputType extends LeafType {
    const type THackType = string;
    const string NAME = 'String';

    <<__Override>>
    protected function coerce(string $value): string {
        return $value;
    }
}
