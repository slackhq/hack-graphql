namespace Graphpinator\Parser\Field;

final class FieldSet {

    public function __construct(
        private vec<Field> $fields,
        private vec<\Graphpinator\Parser\FragmentSpread\FragmentSpread> $fragments,
    ) {
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
