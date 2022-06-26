


namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\Str;
use type Facebook\HackCodegen\{
    CodegenClass,
    CodegenMethod,
    HackCodegenFactory,
    CodegenClassConstant,
    HackBuilderValues,
};

final class InterfaceBuilder extends CompositeBuilder {
    const classname<\Slack\GraphQL\Types\InterfaceType> SUPERCLASS = \Slack\GraphQL\Types\InterfaceType::class;

    <<__Override>>
    public function __construct(
        Context $ctx,
        \Slack\GraphQL\__Private\CompositeType $type_info,
        string $hack_type,
        vec<FieldBuilder> $fields,
        private dict<string, string> $hack_class_to_graphql_object,
    ) {
        parent::__construct($ctx, $type_info, $hack_type, $fields);
    }

    <<__Override>>
    public function build(HackCodegenFactory $cg): CodegenClass {
        return parent::build($cg)
            ->addMethod($this->generateGetObjectTypeForValue($cg))
            ->addConstant($this->generatePossibleTypesConstant($cg));
    }

    private function generateGetObjectTypeForValue(HackCodegenFactory $cg): CodegenMethod {
        $method = $cg->codegenMethod('resolveAsync')
            ->setPublic()
            ->setIsAsync()
            ->setReturnType('Awaitable<GraphQL\\FieldResult<dict<string, mixed>>>')
            ->addParameter('this::THackType $value')
            ->addParameterf('vec<\\%s> $parent_nodes', \Graphpinator\Parser\Field\IHasSelectionSet::class)
            ->addParameterf('\\%s $context', \Slack\GraphQL\ExecutionContext::class);

        $hb = hb($cg);
        foreach ($this->hack_class_to_graphql_object as $hack_class => $graphql_type) {
            if (\is_subclass_of($hack_class, $this->hack_type)) {
                $hb->startIfBlockf('$value is \\%s', $hack_class)
                    ->addReturnf(
                        'await %s::nonNullable()->resolveAsync($value, $parent_nodes, $context)',
                        $graphql_type,
                    )
                    ->endIfBlock();
            }
        }

        $hb->addMultilineCall('invariant_violation', vec[
            "'Class %s has no associated GraphQL type or it is not a subtype of %s.'",
            '\\get_class($value)',
            'static::NAME',
        ]);

        return $method->setBody($hb->getCode());
    }

    private function generatePossibleTypesConstant(HackCodegenFactory $cg): CodegenClassConstant {
        $possible_types = keyset[];
        foreach ($this->hack_class_to_graphql_object as $hack_class => $graphql_class) {
            if (\is_subclass_of($hack_class, $this->hack_type)) {
                $possible_types[] = Str\format('%s::class', $graphql_class);
            }
        }

        return $cg->codegenClassConstant('POSSIBLE_TYPES')
            ->setType('keyset<classname<Types\ObjectType>>')
            ->setValue($possible_types, HackBuilderValues::keyset(HackBuilderValues::literal()));
    }
}
