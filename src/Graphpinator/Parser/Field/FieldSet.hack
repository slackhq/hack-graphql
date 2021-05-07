namespace Graphpinator\Parser\Field;

final class FieldSet extends \Infinityloop\Utils\ObjectSet<Field> {

    private \Graphpinator\Parser\FragmentSpread\FragmentSpreadSet $fragments;

    public function __construct(vec<Field> $fields, \Graphpinator\Parser\FragmentSpread\FragmentSpreadSet $fragments) {
        parent::__construct($fields);
        $this->fragments = $fragments;
    }

    public function getFragmentSpreads(): \Graphpinator\Parser\FragmentSpread\FragmentSpreadSet {
        return $this->fragments;
    }
}
