namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{Keyset, Str};
use type Facebook\HackCodegen\{CodegenClass, CodegenMethod, HackBuilderValues, HackCodegenFactory};

class InputObjectType implements GeneratableClass {
    public function __construct(
        private \ReflectionTypeAlias $reflection_type_alias,
        private \Slack\GraphQL\InputObjectType $input_type,
    ) {}

    public function getType(): string {
        return $this->input_type->getType();
    }

    public function generateClass(HackCodegenFactory $cg): CodegenClass {
        $hack_type = $this->reflection_type_alias->getName();

        $class = $cg->codegenClass($this->input_type->getType())
            ->setIsFinal()
            ->setExtendsf('\%s', \Slack\GraphQL\Types\InputObjectType::class)
            ->addTypeConstant(
                $cg->codegenTypeConstant('TCoerced')->setValue('\\'.$hack_type, HackBuilderValues::literal()),
            );

        $name_const = $cg
            ->codegenClassConstant('NAME')
            ->setValue($this->input_type->getType(), HackBuilderValues::export());

        $class->addConstant($name_const);

        $ts = $this->reflection_type_alias->getResolvedTypeStructure();
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
        $values = hb($cg)->addLine('return shape(')->indent();
        $nodes = hb($cg)->addLine('return shape(')->indent();

        foreach (($ts['fields'] as nonnull) as $field_name => $field_ts) {
            $name_literal = \var_export($field_name, true);
            $type = input_type(self::typeStructureToHackType($field_ts));
            $values->addLinef('%s => %s->coerceValue($args[%s]),', $name_literal, $type, $name_literal);
            $nodes->addLinef('%s => %s->coerceNode($args[%s], $vars),', $name_literal, $type, $name_literal);
        }

        $values->unindent()->addLine(');');
        $nodes->unindent()->addLine(');');

        return $class->addMethods(vec[
            $cg->codegenMethod('coerceFieldValues')
                ->setIsOverride()
                ->addParameter('KeyedContainer<arraykey, mixed> $args')
                ->setReturnType('this::TCoerced')
                ->setBody($values->getCode()),
            $cg->codegenMethod('coerceFieldNodes')
                ->setIsOverride()
                ->addParameterf('KeyedContainer<string, \\%s> $args', \Graphpinator\Parser\Value\Value::class)
                ->addParameter('dict<string, mixed> $vars')
                ->setReturnType('this::TCoerced')
                ->setBody($nodes->getCode()),
        ]);
    }

    private static function typeStructureToHackType<T>(TypeStructure<T> $ts): string {
        $alias = Shapes::idx($ts, 'alias');
        if ($alias is nonnull) {
            return $alias;
        }

        switch ($ts['kind']) {
            case TypeStructureKind::OF_INT:
                return 'HH\int';
            case TypeStructureKind::OF_STRING:
                return 'HH\string';
            case TypeStructureKind::OF_BOOL:
                return 'HH\bool';
            case TypeStructureKind::OF_VEC:
                return Str\format('HH\vec<%s>', self::typeStructureToHackType($ts['generic_types'] as nonnull[0]));
            case TypeStructureKind::OF_ENUM:
            //case TypeStructureKind::OF_UNRESOLVED: // not sure if this is needed
                return $ts['classname'] as nonnull;
            default:
                invariant_violation(
                    'Shape fields %s cannot be used as input object fields.',
                    TypeStructureKind::getNames()[$ts['kind']],
                );
        }
    }
}
