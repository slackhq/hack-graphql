namespace Slack\GraphQL\Codegen;

use type Facebook\HackCodegen\{CodegenTypeConstant, HackBuilderValues, HackCodegenFactory};

abstract class OutputTypeBuilder<T as \Slack\GraphQL\__Private\GraphQLTypeInfo> extends TypeBuilder<T> {
    final public function buildTypeConstant(HackCodegenFactory $cg): CodegenTypeConstant {
        return $cg->codegenTypeConstant('THackType')
            ->setValue('\\'.$this->hack_type, HackBuilderValues::literal());
    }
}
