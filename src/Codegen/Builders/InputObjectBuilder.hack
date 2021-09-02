


namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{Keyset, Str, Vec};
use type Facebook\HackCodegen\{CodegenClass, CodegenMethod, HackBuilderValues, HackCodegenFactory};


class InputObjectBuilder extends InputTypeBuilder<\Slack\GraphQL\InputObjectType> {

    const classname<\Slack\GraphQL\Types\InputObjectType> SUPERCLASS = \Slack\GraphQL\Types\InputObjectType::class;

    public function __construct(\Slack\GraphQL\InputObjectType $type_info, private \ReflectionTypeAlias $type_alias) {
        parent::__construct($type_info, $type_alias->getName());
    }

    public function build(HackCodegenFactory $cg): CodegenClass {
        $class = parent::build($cg);

        $ts = $this->type_alias->getResolvedTypeStructure();
        invariant(
            $ts['kind'] === \HH\TypeStructureKind::OF_SHAPE && !idx($ts, 'nullable', false),
            'Input objects can only be generated from type aliases of a non-nullable shape type, got %s.',
            TypeStructureKind::getNames()[$ts['kind']],
        );

        $class->addConstant(
            $cg->codegenClassConstant('keyset<string> FIELD_NAMES')
                ->setValue(Keyset\keys($ts['fields']), HackBuilderValues::export()),
        );

        return $class->addMethods(vec[
            $cg->codegenMethod('coerceFieldValues')
                ->setIsOverride()
                ->addParameter('KeyedContainer<arraykey, mixed> $fields')
                ->setReturnType('this::THackType')
                ->setBody(
                    self::getFieldCoercionMethodBody(
                        $cg,
                        $ts['fields'],
                        $field_name ==> Str\format('C\\contains_key($fields, %s)', $field_name),
                        $field_name ==> Str\format('coerceNamedValue(%s, $fields)', $field_name),
                    ),
                ),
            $cg->codegenMethod('coerceFieldNodes')
                ->setIsOverride()
                ->addParameterf('dict<string, \\%s> $fields', \Graphpinator\Parser\Value\Value::class)
                ->addParameter('dict<string, mixed> $vars')
                ->setReturnType('this::THackType')
                ->setBody(
                    self::getFieldCoercionMethodBody(
                        $cg,
                        $ts['fields'],
                        $field_name ==> Str\format('$this->hasValue(%s, $fields, $vars)', $field_name),
                        $field_name ==> Str\format('coerceNamedNode(%s, $fields, $vars)', $field_name),
                    ),
                ),
            $cg->codegenMethod('assertValidFieldValues')
                ->setIsOverride()
                ->addParameter('KeyedContainer<arraykey, mixed> $fields')
                ->setReturnType('this::THackType')
                ->setBody(
                    self::getFieldCoercionMethodBody(
                        $cg,
                        $ts['fields'],
                        $field_name ==> Str\format('C\\contains_key($fields, %s)', $field_name),
                        $field_name ==> Str\format('assertValidVariableValue($fields[%s])', $field_name),
                    ),
                ),
            $this->generateGetInputValue($cg, $ts['fields']),
        ]);
    }

    /**
     * Shared logic for coerceFieldValues(), coerceFieldNodes() and assertValidFieldValues()
     */
    private static function getFieldCoercionMethodBody<T>(
        HackCodegenFactory $cg,
        KeyedContainer<string, TypeStructure<T>> $fields,
        (function(string): string) $get_if_condition,
        (function(string): string) $get_method_call,
    ): string {
        $hb = hb($cg)->addLine('$ret = shape();');

        foreach ($fields as $field_name => $field_ts) {
            $is_optional = $field_ts['optional_shape_field'] ?? false;
            $is_nullable = $field_ts['nullable'] ?? false;
            invariant(
                $is_optional === $is_nullable,
                'Field "%s" must be both optional and nullable, or neither (GraphQL doesn\'t distinguish between '.
                'optionality and nullability)',
                $field_name,
            );

            $name_literal = \var_export($field_name, true);
            $type = input_type(type_structure_to_type_alias($field_ts));

            if ($is_optional) {
                $hb->startIfBlock($get_if_condition($name_literal));
            }
            $hb->addLinef('$ret[%s] = %s->%s;', $name_literal, $type, $get_method_call($name_literal));
            if ($is_optional) {
                $hb->endIfBlock();
            }
        }

        $hb->addReturn('$ret', HackBuilderValues::literal());
        return $hb->getCode();
    }

    private function generateGetInputValue<T>(
        HackCodegenFactory $cg,
        KeyedContainer<string, TypeStructure<T>> $fields,
    ): CodegenMethod {
        $method = $cg->codegenMethod('getInputValue')
            ->setProtected()
            ->setIsOverride(true)
            ->setReturnType('?GraphQL\\Introspection\\__InputValue')
            ->addParameter('string $field_name');

        $hb = hb($cg)
            ->startSwitch('$field_name');

        foreach ($fields as $field_name => $field_ts) {
            $hb->addCase($field_name, HackBuilderValues::export());
            $hb->addLine('return shape(')->indent();
            $hb->addLinef("'name' => %s,", \var_export($field_name, true));

            $type = input_type(type_structure_to_type_alias($field_ts));
            $hb->addLinef("'type' => %s,", $type);
            // TODO: description, defaultValue
            $hb->unindent()->addLine(');')->unindent();
        }

        $hb
            ->addDefault()
            ->addLine("return null;")
            ->endDefault()
            ->endSwitch();

        $method->setBody($hb->getCode());
        return $method;
    }
}
