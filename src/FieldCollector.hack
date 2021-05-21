namespace Slack\GraphQL;

use namespace HH\Lib\C;
use namespace Graphpinator\Parser;

/**
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
                throw (new UserFacingError('Missing selection set'))->setLocation($parent_node->getLocation());
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
            // TODO: @skip, @include

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
}
