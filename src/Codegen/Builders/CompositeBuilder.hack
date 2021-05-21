namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\Keyset;
use type Facebook\HackCodegen\{
    CodegenClass,
    CodegenMethod,
    HackBuilderValues,
    HackCodegenFactory,
    CodegenClassConstant,
};


/**
 * Builder for GraphQL objects and interfaces (has a subclass for each).
 *
 * The annotated Hack type should be either a class, interface, or shape.
 */
abstract class CompositeBuilder extends OutputTypeBuilder<\Slack\GraphQL\__Private\CompositeType> {

    public function __construct(
        \Slack\GraphQL\__Private\CompositeType $type_info,
        string $hack_type,
        protected vec<FieldBuilder> $fields,
    ) {
        parent::__construct($type_info, $hack_type);
    }

    public function build(HackCodegenFactory $cg): CodegenClass {
        return parent::build($cg)
            ->addMethod($this->generateGetFieldDefinition($cg))
            ->addConstant($this->generateFieldNamesConstant($cg, $this->getFieldNames()));
    }

    private function generateGetFieldDefinition(HackCodegenFactory $cg): CodegenMethod {
        $method = $cg->codegenMethod('getFieldDefinition')
            ->setPublic()
            ->setReturnType('?GraphQL\\IResolvableFieldDefinition<this::THackType>')
            ->addParameter('string $field_name');

        $hb = hb($cg);
        $hb->startSwitch('$field_name')
            ->addCaseBlocks(
                $this->fields,
                ($field, $hb) ==> {
                    $field->addGetFieldDefinitionCase($hb);
                },
            )
            ->addDefault()
            ->addLine("return null;")
            ->endDefault()
            ->endSwitch();

        $method->setBody($hb->getCode());

        return $method;
    }

    final public function getFieldNames(): keyset<string> {
        return Keyset\map($this->fields, $field ==> $field->getName());
    }

    private function generateFieldNamesConstant(
        HackCodegenFactory $cg,
        keyset<string> $field_names,
    ): CodegenClassConstant {
        return $cg->codegenClassConstant('FIELD_NAMES')
            ->setType('keyset<string>')
            ->setValue($field_names, HackBuilderValues::keyset(HackBuilderValues::export()));
    }
}
