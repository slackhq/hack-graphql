namespace Slack\GraphQL\Codegen;

final class InputEnumBuilder extends InputTypeBuilder<\Slack\GraphQL\EnumType> {
    use EnumBuilder;

    const classname<\Slack\GraphQL\Types\EnumInputType> SUPERCLASS = \Slack\GraphQL\Types\EnumInputType::class;

    protected function getGeneratedClassName(): string {
        return $this->type_info->getInputType();
    }
}
