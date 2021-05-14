namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{C, Str};
use type Facebook\HackCodegen\{HackBuilder, HackBuilderValues};

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
