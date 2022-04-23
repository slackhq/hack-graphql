

namespace Slack\GraphQL\Codegen;

final class Context {
    public function __construct(private dict<string, classname<\Slack\GraphQL\Types\NamedType>> $custom_types) {}

    public function getCustomTypes(): dict<string, classname<\Slack\GraphQL\Types\NamedType>> {
        return $this->custom_types;
    }
}
