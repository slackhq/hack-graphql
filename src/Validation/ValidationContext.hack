namespace Slack\GraphQL\Validation;

use namespace HH\Lib\{C, Str, Vec};
use namespace Graphpinator\Parser;
use namespace Slack\GraphQL\Types;
use type HH\Lib\Ref;
use type Slack\GraphQL\__Private\CallbackVisitor;
use type Slack\GraphQL\__Private\TypeInfo;
use type Slack\GraphQL\__Private\Utils\Stack;

type VariableUsage = shape(
    'node' => Parser\Value\VariableRef,
);


final class ValidationContext {
    private vec<\Slack\GraphQL\UserFacingError> $errors = vec[];
    private dict<int, vec<VariableUsage>> $variable_usages = dict[];
    private dict<int, vec<VariableUsage>> $recursive_variable_usages = dict[];
    private dict<int, vec<Parser\Fragment\Fragment>> $recursively_referenced_fragments = dict[];
    private dict<int, vec<Parser\FragmentSpread\NamedFragmentSpread>> $named_fragment_spreads = dict[];

    public function __construct(
        private classname<\Slack\GraphQL\BaseSchema> $schema,
        private Parser\ParsedRequest $ast,
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

    public function getVariableUsages(Parser\Field\IHasSelectionSet $node): vec<VariableUsage> {
        $usages = $this->variable_usages[$node->getId()] ?? null;
        if ($usages is null) {
            $ref = new Ref(vec[]);
            $visitor = new CallbackVisitor($curr ==> {
                if ($curr is Parser\Value\VariableRef) {
                    $ref->value[] = shape(
                        'node' => $curr,
                    );
                }
            });
            $visitor->visitHasSelectionSet($node);
            $usages = $ref->value;
            $this->variable_usages[$node->getId()] = $usages;
        }
        return $usages;
    }

    public function getRecursiveVariableUsages(Parser\Operation\Operation $operation): vec<VariableUsage> {
        $usages = $this->recursive_variable_usages[$operation->getId()] ?? null;
        if ($usages is null) {
            $usages = $this->getVariableUsages($operation);
            foreach ($this->getRecursivelyReferencedFragments($operation) as $fragment) {
                $usages = Vec\concat($usages, $this->getVariableUsages($fragment));
            }
        }
        return $usages;
    }

    public function getFragment(string $name): ?Parser\Fragment\Fragment {
        $fragments = $this->ast->getFragments();
        return $fragments[$name] ?? null;
    }

    public function getNamedFragmentSpreads(
        Parser\Field\SelectionSet $node,
    ): vec<Parser\FragmentSpread\NamedFragmentSpread> {
        $spreads = $this->named_fragment_spreads[$node->getId()] ?? null;
        if ($spreads is null) {
            $spreads = vec[];
            $sets_to_visit = new Stack(vec[$node]);
            while ($sets_to_visit->length() > 0) {
                $set = $sets_to_visit->pop();
                foreach ($set->getItems() as $selection) {
                    if ($selection is Parser\FragmentSpread\NamedFragmentSpread) {
                        $spreads[] = $selection;
                    } else {
                        $next_selection = $selection ?as Parser\Field\IHasSelectionSet?->getSelectionSet();
                        if ($next_selection) {
                            $sets_to_visit->push($next_selection);
                        }
                    }
                }
            }
            $this->named_fragment_spreads[$node->getId()] = $spreads;
        }
        return $spreads;
    }

    public function getRecursivelyReferencedFragments(
        Parser\Operation\Operation $operation,
    ): vec<Parser\Fragment\Fragment> {
        $fragments = $this->recursively_referenced_fragments[$operation->getId()] ?? null;
        if ($fragments is null) {
            $fragments = vec[];
            $collected_names = keyset[];
            $nodes_to_visit = new Stack(vec[$operation->getSelectionSet()]);
            while ($nodes_to_visit->length() > 0) {
                $node = $nodes_to_visit->pop();
                foreach ($this->getNamedFragmentSpreads($node) as $spread) {
                    if (!C\contains_key($collected_names, $spread->getName())) {
                        $collected_names[] = $spread->getName();
                        $fragment = $this->getFragment($spread->getName());
                        if ($fragment) {
                            $fragments[] = $fragment;
                            $nodes_to_visit->push($fragment->getSelectionSet());
                        }
                    }
                }
            }
            $this->recursively_referenced_fragments[$operation->getId()] = $fragments;
        }
        return $fragments;
    }
}
