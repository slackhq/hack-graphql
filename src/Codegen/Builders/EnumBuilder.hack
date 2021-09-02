


namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\Vec;
use type Facebook\HackCodegen\{CodegenClass, HackBuilderValues, HackCodegenFactory, CodegenClassConstant};

final class EnumBuilder extends TypeBuilder<\Slack\GraphQL\EnumType> implements ITypeBuilder {
    const classname<\Slack\GraphQL\Types\EnumType> SUPERCLASS = \Slack\GraphQL\Types\EnumType::class;

    final public function build(HackCodegenFactory $cg): CodegenClass {
        return parent::build($cg)
            ->addConstant(
                $cg->codegenClassConstant('HACK_ENUM')
                    ->setType('\\HH\\enumname<this::THackType>')
                    ->setValue('\\'.$this->hack_type.'::class', HackBuilderValues::literal()),
            )
            ->addConstant($this->generateEnumValuesConstant($cg));
    }

    private function generateEnumValuesConstant(HackCodegenFactory $cg): CodegenClassConstant {
        $rc = new \ReflectionClass($this->hack_type);
        $values = vec[];

        foreach ($rc->getConstants() as $name => $_) {
            $values[] = shape(
                'name' => $name,
                // TODO: isDeprecated, description, deprecationReason
                'isDeprecated' => false,
            );
        }

        $constant = $cg->codegenClassConstant('ENUM_VALUES')
            ->setType('vec<GraphQL\Introspection\__EnumValue>')
            ->setValue(
                $values,
                HackBuilderValues::vec(HackBuilderValues::shapeWithUniformRendering(HackBuilderValues::export())),
            );
        return $constant;
    }
}
