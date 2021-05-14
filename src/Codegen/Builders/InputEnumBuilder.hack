namespace Slack\GraphQL\Codegen;

use type Facebook\HackCodegen\{CodegenClass, HackBuilderValues, HackCodegenFactory};

final class InputEnumBuilder extends InputTypeBuilder<\Slack\GraphQL\EnumType> {

    const classname<\Slack\GraphQL\Types\EnumInputType> SUPERCLASS = \Slack\GraphQL\Types\EnumInputType::class;

    protected function getGeneratedClassName(): string {
        return $this->type_info->getInputType();
    }

    public function build(HackCodegenFactory $cg): CodegenClass {
        return parent::build($cg)
            ->addConstant(
                $cg->codegenClassConstant('HACK_ENUM')
                    ->setType('\\HH\\enumname<this::TCoerced>')
                    ->setValue('\\'.$this->hack_type.'::class', HackBuilderValues::literal()),
            );
    }
}
