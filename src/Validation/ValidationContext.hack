namespace Slack\GraphQL\Validation;

use namespace HH\Lib\Str;
use namespace Graphpinator\Parser;
use namespace Slack\GraphQL\Types;
use type Slack\GraphQL\__Private\{FragmentInfo, TypeInfo, VariableInfo};

final class ValidationContext {
    private vec<\Slack\GraphQL\UserFacingError> $errors = vec[];

    public function __construct(
        private classname<\Slack\GraphQL\BaseSchema> $schema,
        // TODO: Pass in parsed AST as well as rules may need it.
        private FragmentInfo $fragment_info,
        private TypeInfo $type_info,
        private VariableInfo $variable_info,
    ) {}

    public function reportError(
        \Graphpinator\Parser\Node $node,
        Str\SprintfFormatString $message,
        mixed ...$args
    ): void {
        $error = new \Slack\GraphQL\UserFacingError('%s', \vsprintf($message, $args));
        $error->setPath($this->type_info->getPath());
        $error->setLocation($node->getLocation());
        $this->errors[] = $error;
    }

    public function getErrors(): vec<\Slack\GraphQL\UserFacingError> {
        return $this->errors;
    }

    public function getSchema(): classname<\Slack\GraphQL\BaseSchema> {
        return $this->schema;
    }

    public function getType(): ?Types\IOutputType {
        return $this->type_info->getType();
    }

    public function getParentType(): ?Types\INamedOutputType {
        return $this->type_info->getParentType();
    }

    public function getInputType(): ?Types\IInputType {
        return $this->type_info->getInputType();
    }

    public function getFieldDef(): ?\Slack\GraphQL\IFieldDefinition {
        return $this->type_info->getFieldDef();
    }

    public function getArgument(): ?\Slack\GraphQL\ArgumentDefinition {
        return $this->type_info->getArgument();
    }

    public function getVariableUsages(Parser\Operation\Operation $operation): vec<Parser\Value\VariableRef> {
        return $this->variable_info->getVariableUsages($operation);
    }
}
