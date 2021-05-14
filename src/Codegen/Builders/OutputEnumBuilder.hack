namespace Slack\GraphQL\Codegen;

use type Facebook\HackCodegen\{CodegenClass, HackBuilderValues, HackCodegenFactory};

final class OutputEnumBuilder extends OutputTypeBuilder<\Slack\GraphQL\EnumType> {

    const classname<\Slack\GraphQL\Types\EnumOutputType> SUPERCLASS = \Slack\GraphQL\Types\EnumOutputType::class;

    protected function getGeneratedClassName(): string {
        return $this->type_info->getOutputType();
    }

    public function build(HackCodegenFactory $cg): CodegenClass {
        return parent::build($cg)
            ->addConstant(
                $cg->codegenClassConstant('HACK_ENUM')
                    ->setType('\\HH\\enumname<this::THackType>')
                    ->setValue('\\'.$this->hack_type.'::class', HackBuilderValues::literal()),
            );
    }
}
