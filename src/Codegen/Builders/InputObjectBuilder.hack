namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{Keyset, Str};
use type Facebook\HackCodegen\{CodegenClass, CodegenMethod, HackBuilderValues, HackCodegenFactory};


class InputObjectBuilder extends InputTypeBuilder<\Slack\GraphQL\InputObjectType> {

    const classname<\Slack\GraphQL\Types\InputObjectType> SUPERCLASS = \Slack\GraphQL\Types\InputObjectType::class;

    public function __construct(\Slack\GraphQL\InputObjectType $type_info, private \ReflectionTypeAlias $type_alias) {
        parent::__construct($type_info, $type_alias->getName());
    }

    public function build(HackCodegenFactory $cg): CodegenClass {
        $class = parent::build($cg);
        $class->addMethod($this->generateGetDescription($cg));

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

        // coerceFieldValues() and coerceFieldNodes()
        $values = hb($cg)->addLine('$ret = shape();');
        $nodes = hb($cg)->addLine('$ret = shape();');

        foreach (($ts['fields'] as nonnull) as $field_name => $field_ts) {
            $is_optional = $field_ts['optional_shape_field'] ?? false;
            $is_nullable = $field_ts['nullable'] ?? false;
            invariant(
                $is_optional === $is_nullable,
                'Field "%s" must be both optional and nullable, or neither (GraphQL doesn\'t distinguish between '.
                'optionality and nullability)',
                $field_name,
            );

            $name_literal = \var_export($field_name, true);
            $type = input_type(($is_optional ? '?' : '').type_structure_to_type_alias($field_ts));

            if ($is_optional) {
                $values->startIfBlockf('C\\contains_key($fields, %s)', $name_literal);
                $nodes->startIfBlockf('$this->hasValue(%s, $fields, $vars)', $name_literal);
            }

            $values->addLinef('$ret[%s] = %s->coerceNamedValue(%s, $fields);', $name_literal, $type, $name_literal);
            $nodes
                ->addLinef('$ret[%s] = %s->coerceNamedNode(%s, $fields, $vars);', $name_literal, $type, $name_literal);

            if ($is_optional) {
                $values->endIfBlock();
                $nodes->endIfBlock();
            }
        }

        $values->addReturn('$ret', HackBuilderValues::literal());
        $nodes->addReturn('$ret', HackBuilderValues::literal());

        return $class->addMethods(vec[
            $cg->codegenMethod('coerceFieldValues')
                ->setIsOverride()
                ->addParameter('KeyedContainer<arraykey, mixed> $fields')
                ->setReturnType('this::THackType')
                ->setBody($values->getCode()),
            $cg->codegenMethod('coerceFieldNodes')
                ->setIsOverride()
                ->addParameterf('dict<string, \\%s> $fields', \Graphpinator\Parser\Value\Value::class)
                ->addParameter('dict<string, mixed> $vars')
                ->setReturnType('this::THackType')
                ->setBody($nodes->getCode()),
        ]);
    }
}
