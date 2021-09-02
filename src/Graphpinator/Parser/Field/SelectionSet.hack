
namespace Graphpinator\Parser\Field;

/**
 * @see https://spec.graphql.org/draft/#sec-Selection-Sets
 */
final class SelectionSet extends \Graphpinator\Parser\Node {

    public function __construct(\Graphpinator\Common\Location $location, private vec<ISelectionSetItem> $items) {
        parent::__construct($location);
    }

    public function getItems(): vec<ISelectionSetItem> {
        return $this->items;
    }
}

interface IHasSelectionSet {
    require extends \Graphpinator\Parser\Node;
    public function getSelectionSet(): ?SelectionSet;
}

<<__Sealed(Field::class, \Graphpinator\Parser\FragmentSpread\FragmentSpread::class)>>
interface ISelectionSetItem {
    require extends \Graphpinator\Parser\Node;
    public function getDirectives(): ?vec<\Graphpinator\Parser\Directive\Directive>;
}
