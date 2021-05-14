namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{C, Str};
use type Facebook\HackCodegen\{CodegenMethod, HackBuilder, HackBuilderValues};


interface IFieldBuilder {
    public function addGetFieldDefinitionCase(HackBuilder $hb): void;
}


class MethodFieldBuilder implements IFieldBuilder {
    public function __construct(
        protected \Slack\GraphQL\Field $graphql_field,
        protected \ReflectionMethod $reflection_method,
    ) {}

    public function addGetFieldDefinitionCase(HackBuilder $hb): void {
        $hb->addCase($this->graphql_field->getName(), HackBuilderValues::export());

        $hb->addLine('return new GraphQL\\FieldDefinition(')->indent();

        // Field return type
        $type_info = output_type(
            $this->reflection_method->getReturnTypeText(),
            $this->reflection_method->getAttributeClass(\Slack\GraphQL\KillsParentOnException::class) is nonnull,
        );
        $hb->addLinef('%s,', $type_info['type']);

        // Arguments
        $hb->addf(
            'async ($parent, $args, $vars) ==> %s%s%s(',
            $type_info['needs_await'] ? 'await ' : '',
            $this->getMethodCallPrefix(),
            $this->reflection_method->getName(),
        );
        $args = $this->getArgumentInvocationStrings();
        if (!C\is_empty($args)) {
            $hb->newLine()->indent();
            foreach ($args as $arg) {
                $hb->addLinef('%s,', $arg);
            }
            $hb->unindent();
        }
        $hb->addLine('),');

        // End of new GraphQL\FieldDefinition(
        $hb->unindent()->addLine(');');
        $hb->unindent();
    }

    protected function getMethodCallPrefix(): string {
        return '$parent->';
    }

    public function hasArguments(): bool {
        return $this->reflection_method->getNumberOfParameters() > 0;
    }

    protected function getArgumentInvocationStrings(): vec<string> {
        $invocations = vec[];
        foreach ($this->reflection_method->getParameters() as $index => $param) {
            $invocations[] = Str\format(
                '%s->coerceNode($args[%s]->getValue(), $vars)',
                input_type($param->getTypeText()),
                \var_export($param->getName(), true),
            );
        }
        return $invocations;
    }
}


class QueryFieldBuilder extends MethodFieldBuilder {
    <<__Override>>
    protected function getMethodCallPrefix(): string {
        $class = $this->reflection_method->getDeclaringClass();
        return '\\'.$class->getName().'::';
    }
}


class MutationFieldBuilder extends QueryFieldBuilder {}


class ShapeFieldBuilder<T> implements IFieldBuilder {
    public function __construct(private string $field_name, private TypeStructure<T> $type_structure) {}

    public function addGetFieldDefinitionCase(HackBuilder $hb): void {
        $name_literal = \var_export($this->field_name, true);

        $hb->addCase($name_literal, HackBuilderValues::literal());
        $hb->addLine('return new GraphQL\\FieldDefinition(')->indent();

        // Field return type
        $type_info = output_type(type_structure_to_type_alias($this->type_structure), false);
        $hb->addLinef('%s,', $type_info['type']);

        $hb->addf(
            'async ($parent, $args, $vars) ==> $parent[%s]%s',
            $name_literal,
            Shapes::idx($this->type_structure, 'optional_shape_field', false) ? ' ?? null' : '',
        );
        $hb->addLine(',');

        // End of new GraphQL\FieldDefinition(
        $hb->unindent()->addLine(');');
        $hb->unindent();
    }
}
