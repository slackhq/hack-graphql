namespace Slack\GraphQL\Validation;

use namespace HH\Lib\Str;
use namespace \Slack\GraphQL\Types;


final class ValidationContext {
    private vec<\Slack\GraphQL\UserFacingError> $errors = vec[];

    public function __construct(
        private \Slack\GraphQL\BaseSchema $schema,
        // TODO: Pass in parsed AST as well as rules may need it.
        private TypeInfo $type_info,
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

    public function getSchema(): \Slack\GraphQL\BaseSchema {
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
}
