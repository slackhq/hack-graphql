namespace Slack\GraphQL\Codegen;

final class OutputEnumBuilder extends OutputTypeBuilder<\Slack\GraphQL\EnumType> {
    use EnumBuilder;

    const classname<\Slack\GraphQL\Types\EnumOutputType> SUPERCLASS = \Slack\GraphQL\Types\EnumOutputType::class;

    protected function getGeneratedClassName(): string {
        return $this->type_info->getOutputType();
    }
}
