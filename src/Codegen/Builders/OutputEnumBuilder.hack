namespace Slack\GraphQL\Codegen;

use type Facebook\HackCodegen\{CodegenClass, HackCodegenFactory};

final class OutputEnumBuilder extends OutputTypeBuilder<\Slack\GraphQL\EnumType> {
    use EnumBuilder;

    const classname<\Slack\GraphQL\Types\EnumOutputType> SUPERCLASS = \Slack\GraphQL\Types\EnumOutputType::class;

    protected function getGeneratedClassName(): string {
        return $this->type_info->getOutputType();
    }

    <<__Override>>
    public function build(HackCodegenFactory $cg): CodegenClass {
        return $this->buildShared($cg);
    }
}
