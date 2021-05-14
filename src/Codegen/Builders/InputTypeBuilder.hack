namespace Slack\GraphQL\Codegen;

use type Facebook\HackCodegen\{CodegenTypeConstant, HackBuilderValues, HackCodegenFactory};


abstract class InputTypeBuilder<T as \Slack\GraphQL\__Private\GraphQLTypeInfo> extends TypeBuilder<T> {
    final public function buildTypeConstant(HackCodegenFactory $cg): CodegenTypeConstant {
        return $cg->codegenTypeConstant('TCoerced')
            ->setValue('\\'.$this->hack_type, HackBuilderValues::literal());
    }
}
