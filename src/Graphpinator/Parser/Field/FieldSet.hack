namespace Graphpinator\Parser\Field;

final class FieldSet extends \Graphpinator\Parser\Node {

    public function __construct(
        \Graphpinator\Common\Location $location,
        private vec<Field> $fields,
        private vec<\Graphpinator\Parser\FragmentSpread\FragmentSpread> $fragments,
    ) {
        parent::__construct($location);
        $this->fragments = $fragments;
    }

    public function getFields(): vec<Field> {
        return $this->fields;
    }

    public function getFragmentSpreads(): vec<\Graphpinator\Parser\FragmentSpread\FragmentSpread> {
        return $this->fragments;
    }
}

interface IHasFieldSet {
    public function getFields(): ?FieldSet;
}
