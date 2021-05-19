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
 * Base class for all type builders.
 *
 * In general, type builders meant to be used by the generator should subclass
 * `InputTypeBuilder` or `OutputTypeBuilder`. `TypeBuilder` itself is an
 * internal implementation detail which encapsulates shared logic.
 */
abstract class TypeBuilder<T as \Slack\GraphQL\__Private\GraphQLTypeInfo> {

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
            ->addConstant($this->generateNameConstant($cg))
            ->addTypeConstant($this->generateTypeConstant($cg));
    }

    protected function generateNameConstant(HackCodegenFactory $cg): CodegenClassConstant {
        return $cg
            ->codegenClassConstant('NAME')
            ->setValue($this->getGraphQLType(), HackBuilderValues::export());
    }

    protected function generateDescriptionConstant(HackCodegenFactory $cg): CodegenClassConstant {
        // TODO
        return $cg
            ->codegenClassConstant('DESCRIPTION')
            ->setType('?string')
            ->setValue(null, HackBuilderValues::export());
    }

    private function generateTypeConstant(HackCodegenFactory $cg): CodegenTypeConstant {
        return $cg
            ->codegenTypeConstant('THackType')
            ->setValue('\\'.$this->hack_type, HackBuilderValues::literal());
    }

    // TODO: remove this
    public function buildIntrospectionClass(HackCodegenFactory $cg): ?CodegenClass {
        return null;
    }

}
