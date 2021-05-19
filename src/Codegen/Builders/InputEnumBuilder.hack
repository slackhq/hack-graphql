namespace Slack\GraphQL\Codegen;

use type Facebook\HackCodegen\{CodegenClass, HackBuilderValues, HackCodegenFactory};

final class InputEnumBuilder extends InputTypeBuilder<\Slack\GraphQL\EnumType> {
    use EnumBuilder;

    const classname<\Slack\GraphQL\Types\EnumInputType> SUPERCLASS = \Slack\GraphQL\Types\EnumInputType::class;

    protected function getGeneratedClassName(): string {
        return $this->type_info->getInputType();
    }

    <<__Override>>
    public function build(HackCodegenFactory $cg): CodegenClass {
        return $this->buildShared($cg)
            ->addConstant(
                $cg->codegenClassConstant('OUTPUT_TYPE_CLASS')
                    ->setType('classname<Types\\EnumOutputType>')
                    ->setValue($this->type_info->getOutputType().'::class', HackBuilderValues::literal()),
            );
    }
}
