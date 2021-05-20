namespace Slack\GraphQL\Codegen;

use type Facebook\HackCodegen\{CodegenClass, HackBuilderValues, HackCodegenFactory};

final class EnumBuilder extends TypeBuilder<\Slack\GraphQL\EnumType> implements ITypeBuilder {
    const classname<\Slack\GraphQL\Types\EnumType> SUPERCLASS = \Slack\GraphQL\Types\EnumType::class;

    final public function build(HackCodegenFactory $cg): CodegenClass {
        return parent::build($cg)
            ->addConstant(
                $cg->codegenClassConstant('HACK_ENUM')
                    ->setType('\\HH\\enumname<this::THackType>')
                    ->setValue('\\'.$this->hack_type.'::class', HackBuilderValues::literal()),
            );
    }
}
