namespace Slack\GraphQL\Codegen;

use type Facebook\HackCodegen\{
    CodegenClass,
    HackCodegenFactory,
};

abstract class OutputTypeBuilder<T as \Slack\GraphQL\__Private\GraphQLTypeInfo>
    extends TypeBuilder<T>
    implements ITypeBuilder {

    <<__Override>>
    public function build(HackCodegenFactory $cg): CodegenClass {
        return parent::build($cg)->addMethod($this->generateGetDescription($cg));
    }
}
