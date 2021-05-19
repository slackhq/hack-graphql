namespace Slack\GraphQL\Codegen;

use type Facebook\HackCodegen\{CodegenClass, HackBuilderValues, HackCodegenFactory};

trait EnumBuilder {
    require extends TypeBuilder<\Slack\GraphQL\EnumType>;

    private function buildShared(HackCodegenFactory $cg): CodegenClass {
        return parent::build($cg)
            ->addConstant(
                $cg->codegenClassConstant('HACK_ENUM')
                    ->setType('\\HH\\enumname<this::THackType>')
                    ->setValue('\\'.$this->hack_type.'::class', HackBuilderValues::literal()),
            );
    }
}
