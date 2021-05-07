namespace Graphpinator\Parser;

final class ParsedRequest {

    public function __construct(
        private \Graphpinator\Parser\Operation\OperationSet $operations,
        private \Graphpinator\Parser\Fragment\FragmentSet $fragments,
    ) {}

    public function getOperations(): \Graphpinator\Parser\Operation\OperationSet {
        return $this->operations;
    }

    public function getFragments(): \Graphpinator\Parser\Fragment\FragmentSet {
        return $this->fragments;
    }
}
