namespace Slack\GraphQL\Validation;

use namespace \Graphpinator\Parser;
use namespace \Slack\GraphQL\Types;
use type \Slack\GraphQL\__Private\ASTVisitor;
use type \Slack\GraphQL\__Private\Utils\Stack;


/**
 * `TypeInfo` is a utility class which allows us to move through a request AST
 * and GQL schema in parallel: whenever we enter or leave an AST node, `TypeInfo`
 * adjusts our position in the schema accordingly. This is useful, for example,
 * during validation, since the schema nodes pointed to by `TypeInfo` will
 * correspond to the AST node being inspected.
 */
final class TypeInfo extends ASTVisitor {

    private \Slack\GraphQL\BaseSchema $schema;
    private Stack<?Types\IOutputType> $type_stack;
    private Stack<?Types\NamedOutputType> $parent_type_stack;
    private Stack<?Types\IInputType> $input_type_stack;
    private Stack<?\Slack\GraphQL\IFieldDefinition> $field_def_stack;

    public function __construct(\Slack\GraphQL\BaseSchema $schema) {
        $this->schema = $schema;
        $this->type_stack = new Stack();
        $this->parent_type_stack = new Stack();
        $this->input_type_stack = new Stack();
        $this->field_def_stack = new Stack();
    }

    public function getParentType(): ?Types\NamedOutputType {
        return $this->parent_type_stack->peek();
    }

    public function getType(): ?Types\IOutputType {
        return $this->type_stack->peek();
    }

    public function getInputType(): ?Types\IInputType {
        return $this->input_type_stack->peek();
    }

    public function getFieldDef(): ?\Slack\GraphQL\Introspection\__Field {
        return $this->field_def_stack->peek();
    }

    <<__Override>>
    public function enterFieldSet(Parser\Field\FieldSet $node): void {
        $named_type = $this->type_stack->peek()?->getNamedType();
        $this->parent_type_stack->push($named_type is Types\CompositeType ? $named_type : null);
    }

    <<__Override>>
    public function leaveFieldSet(Parser\Field\FieldSet $node): void {
        $this->parent_type_stack->pop();
    }

    <<__Override>>
    public function enterField(Parser\Field\Field $node): void {
        $parent_type = $this->getParentType();
        $field_definition = null;
        $field_type = null;
        if ($parent_type is Types\ObjectType) {
            $field_definition = $parent_type->getFieldDefinition($node->getName());
            if ($field_definition) {
                $field_type = $field_definition->getType();
            }
        }
        $this->field_def_stack->push($field_definition);
        $this->type_stack->push($field_type);
    }

    <<__Override>>
    public function leaveField(Parser\Field\Field $node): void {
        $this->field_def_stack->pop();
        $this->type_stack->pop();
    }

    <<__Override>>
    public function enterOperation(Parser\Operation\Operation $node): void {
        $schema = $this->schema;
        switch ($node->getType()) {
            case \Graphpinator\Tokenizer\OperationType::QUERY:
                $type = $this->schema->getQueryType();
                break;
            case \Graphpinator\Tokenizer\OperationType::MUTATION:
                $type = $this->schema->getMutationType();
                break;
            default:
                // TODO: Subscriptions
                throw new \Slack\GraphQL\UserFacingError("Unrecognized type: %s", $node->getType());
        }
        $this->type_stack->push($type);
    }

    <<__Override>>
    public function leaveOperation(Parser\Operation\Operation $node): void {
        $this->type_stack->pop();
    }

    // TODO: Implement more enter / leave methods.
}
