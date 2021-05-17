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

    // TODO: We need to also record the location at which the error occured, but 
    // Graphpinator does not store this info on the AST. We should change that.
    public function reportError(nonnull $_node, Str\SprintfFormatString $message, mixed ...$args): void {
        $error = new \Slack\GraphQL\UserFacingError('%s', \vsprintf($message, $args));
        $error->setPath($this->type_info->getPath());
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

    public function getParentType(): ?Types\NamedOutputType {
        return $this->type_info->getParentType();
    }

    public function getInputType(): ?Types\IInputType {
        return $this->type_info->getInputType();
    }

    public function getFieldDef(): ?\Slack\GraphQL\Introspection\__Field {
        return $this->type_info->getFieldDef();
    }
}
