namespace Slack\GraphQL\__Private;

use namespace HH\Lib\Vec;
use namespace \Graphpinator\Parser;
use namespace \Slack\GraphQL\Types;
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
    private Stack<?Types\INamedOutputType> $parent_type_stack;
    private Stack<?Types\IInputType> $input_type_stack;
    private Stack<?\Slack\GraphQL\IFieldDefinition> $field_def_stack;
    private Stack<mixed> $default_value_stack;
    private ?\Slack\GraphQL\Introspection\__InputValue $argument = null;

    public function __construct(\Slack\GraphQL\BaseSchema $schema) {
        $this->schema = $schema;
        $this->type_stack = new Stack();
        $this->parent_type_stack = new Stack();
        $this->input_type_stack = new Stack();
        $this->field_def_stack = new Stack();
        $this->default_value_stack = new Stack();
    }

    public function getParentType(): ?Types\INamedOutputType {
        return $this->parent_type_stack->peek();
    }

    public function getType(): ?Types\IOutputType {
        return $this->type_stack->peek();
    }

    public function getInputType(): ?Types\IInputType {
        return $this->input_type_stack->peek();
    }

    public function getFieldDef(): ?\Slack\GraphQL\IFieldDefinition {
        return $this->field_def_stack->peek();
    }

    public function getPath(): vec<string> {
        return $this->field_def_stack->asVec()
            |> Vec\filter_nulls($$)
            |> Vec\map($$, $field ==> $field->getName());
    }

    public function getArgument(): ?\Slack\GraphQL\Introspection\__InputValue {
        return $this->argument;
    }

    // TODO: Implement more enter / leave cases.

    <<__Override>>
    public function enter(Parser\Node $node): void {
        if ($node is Parser\Field\SelectionSet) {
            $named_type = $this->type_stack->peek()?->unwrapType();
            $this->parent_type_stack->push($named_type is Types\CompositeType ? $named_type : null);
        } else if ($node is Parser\Field\Field) {
            $parent_type = $this->getParentType();
            $field_definition = null;
            $field_type = null;
            if ($parent_type is Types\CompositeType) {
                $field_definition = $parent_type->getFieldDefinition($node->getName());
                if ($field_definition) {
                    $field_type = $field_definition->getType();
                }
            }
            $this->field_def_stack->push($field_definition);
            $this->type_stack->push($field_type);
        } else if ($node is Parser\Operation\Operation) {
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
        } else if ($node is Parser\FragmentSpread\InlineFragmentSpread || $node is Parser\Fragment\Fragment) {
            $type_condition = $node->getTypeCond();
            $output_type = $type_condition ? $this->schema->getType($type_condition->getName()) : $this->getType();
            $this->type_stack->push($output_type is Types\IOutputType ? $output_type : null);
        } else if ($node is Parser\Value\ArgumentValue) {
            // TODO: Handle directives
            $arg_def = null;
            $arg_type = null;
            $field_definition = $this->getFieldDef();
            if ($field_definition) {
                $arg_def = $field_definition->getArguments()[$node->getName()] ?? null;
                // TODO: Should we be unwrapping this?
                $arg_type = ($arg_type['type'] ?? null)?->unwrapType();
            }
            $this->argument = $arg_def;
            $this->default_value_stack->push($arg_def['default_value'] ?? null);
            $this->input_type_stack->push($arg_type);
        }
    }

    <<__Override>>
    public function leave(Parser\Node $node): void {
        if ($node is Parser\Field\SelectionSet) {
            $this->parent_type_stack->pop();
        } else if ($node is Parser\Field\Field) {
            $this->field_def_stack->pop();
            $this->type_stack->pop();
        } else if (
            $node is Parser\Operation\Operation ||
            $node is Parser\FragmentSpread\InlineFragmentSpread ||
            $node is Parser\Fragment\Fragment
        ) {
            $this->type_stack->pop();
        } else if ($node is Parser\Value\ArgumentValue) {
            $this->argument = null;
            $this->default_value_stack->pop();
            $this->input_type_stack->pop();
        }
    }
}
