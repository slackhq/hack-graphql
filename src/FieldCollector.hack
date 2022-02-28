


namespace Slack\GraphQL;

use namespace HH\Lib\C;
use namespace Graphpinator\Parser;

/**
 * Combines the selection sets of all the given $parent_nodes, recursing into any fragment references whose type matches
 * the provided $parent_type.
 *
 * The output is a dict where each item represents a single field that should be included in the GraphQL response,
 * indexed by the key that should be used for this field in the response (an alias if specified, otherwise the field's
 * name).
 *
 * Note that while each item represents a single field in the *response*, it may actually represent multiple field nodes
 * from the GraphQL query (e.g. if the same field is included via 2 different fragments). The value for each response
 * key is therefore a vec of field nodes. This is also why we accept a vec of $parent_nodes as an input.
 *
 * @see https://spec.graphql.org/draft/#sec-Field-Collection
 */
final class FieldCollector {

    public static function collectFields(
        Types\ObjectType $parent_type,
        vec<Parser\Field\IHasSelectionSet> $parent_nodes,
        ExecutionContext $context,
    ): dict<string, vec<Parser\Field\Field>> {
        $field_collector = new self($parent_type, $context);

        foreach ($parent_nodes as $parent_node) {
            $selection_set = $parent_node->getSelectionSet();
            if ($selection_set is null) {
                // This can only happen if the query wasn't validated.
                continue;
            }
            $field_collector->processSelectionSet($selection_set);
        }

        return $field_collector->groupedFields;
    }


    private dict<string, vec<Parser\Field\Field>> $groupedFields = dict[];
    private keyset<string> $visitedFragments = keyset[];

    private function __construct(private Types\ObjectType $parentType, private ExecutionContext $context) {}

    private function processSelectionSet(Parser\Field\SelectionSet $selection_set): void {
        foreach ($selection_set->getItems() as $item) {
            if ($this->shouldSkip($item)) {
                continue;
            }

            if ($item is Parser\Field\Field) {
                $key = $item->getAlias() ?? $item->getName();
                $this->groupedFields[$key] ??= vec[];
                $this->groupedFields[$key][] = $item;

            } else if ($item is Parser\FragmentSpread\NamedFragmentSpread) {
                if (C\contains_key($this->visitedFragments, $item->getName())) {
                    continue;
                }
                $this->visitedFragments[] = $item->getName();

                $fragment = $this->context->getFragment($item->getName());
                if ($fragment is null) {
                    // This can only happen if the query wasn't validated.
                    continue;
                }
                if (!$this->doesFragmentTypeApply($fragment->getTypeCond())) {
                    continue;
                }

                $this->processSelectionSet($fragment->getSelectionSet());

            } else {
                $item as Parser\FragmentSpread\InlineFragmentSpread;

                $fragment_type = $item->getTypeCond();
                if ($fragment_type is nonnull && !$this->doesFragmentTypeApply($fragment_type)) {
                    continue;
                }

                $this->processSelectionSet($item->getSelectionSet());
            }
        }
    }

    private function doesFragmentTypeApply(Parser\TypeRef\NamedTypeRef $fragment_type): bool {
        $name = $fragment_type->getName();
        return $name === $this->parentType->getName() || C\contains_key($this->parentType->getInterfaces(), $name);
    }

    /**
     * Field/fragment is skipped if *any* of the provided directives applies. Invalid directives (e.g. missing `if`
     * argument) are ignored here (they should be caught during validation).
     */
    private function shouldSkip(Parser\Field\ISelectionSetItem $item): bool {
        foreach ($item->getDirectives() ?? vec[] as $directive) {
            $arg = idx($directive->getArguments(), 'if');
            if ($arg is null) {
                // This can only happen if the query wasn't validated.
                continue;
            }

            try {
                $arg_is_true =
                    Types\BooleanType::nonNullable()->coerceNode($arg->getValue(), $this->context->getVariableValues());
            } catch (UserFacingError $_) {
                // This can only happen if the query wasn't validated or if variable values weren't coerced to the
                // correct type at the beginning of execution.
                continue;
            }

            if (
                $directive->getName() === 'skip' && $arg_is_true || // @skip(if: true)
                $directive->getName() === 'include' && !$arg_is_true // @include(if: false)
            ) {
                return true;
            }
        }

        return false;
    }
}
