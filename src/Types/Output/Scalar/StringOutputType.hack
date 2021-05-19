namespace Slack\GraphQL\Types;

final class StringOutputType extends ScalarOutputType {
    const type THackType = string;
    const string NAME = 'String';

    <<__Override>>
    protected function coerce(string $value): string {
        return $value;
    }

    <<__Override>>
    public function getDescription(): string {
        return 'TODO';
    }
}
