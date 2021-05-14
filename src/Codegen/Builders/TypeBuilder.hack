namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{C, Str};
use type Facebook\HackCodegen\{
    CodegenClass,
    CodegenClassConstant,
    CodegenTypeConstant,
    HackBuilderValues,
    HackCodegenFactory,
};


/**
 * A builder which creates a GraphQL type representing a Hack type,
 * where a HackType is an interface, object, enum, etc.
 */
interface ITypeBuilder {
    public function getGraphQLType(): string;
    public function build(HackCodegenFactory $cg): CodegenClass;
}


abstract class TypeBuilder<T as \Slack\GraphQL\__Private\GraphQLTypeInfo> implements ITypeBuilder {

    abstract const classname<\Slack\GraphQL\Types\BaseType> SUPERCLASS;

    public function __construct(protected T $type_info, protected string $hack_type) {}

    final public function getGraphQLType(): string {
        return $this->type_info->getType();
    }

    protected function getGeneratedClassName(): string {
        return $this->getGraphQLType();
    }

    public function build(HackCodegenFactory $cg): CodegenClass {
        return $cg
            ->codegenClass($this->getGeneratedClassName())
            ->setIsFinal()
            ->setExtendsf('\%s', static::SUPERCLASS)
            ->addConstant($this->buildName($cg))
            ->addTypeConstant($this->buildTypeConstant($cg));
    }

    final private function buildName(HackCodegenFactory $cg): CodegenClassConstant {
        return $cg->codegenClassConstant('NAME')
            ->setValue($this->getGraphQLType(), HackBuilderValues::export());
    }

    abstract protected function buildTypeConstant(HackCodegenFactory $cg): CodegenTypeConstant;
}
