namespace Slack\GraphQL\Types;

final class BooleanOutputType extends ScalarOutputType {
    const type THackType = bool;
    const string NAME = 'Boolean';

    <<__Override>>
    protected function coerce(bool $value): bool {
        return $value;
    }
}
