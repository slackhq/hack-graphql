namespace Graphpinator\Parser;

final class ParsedRequest extends Node {

    public function __construct(
        int $id,
        \Graphpinator\Common\Location $location,
        private dict<string, \Graphpinator\Parser\Operation\Operation> $operations,
        private dict<string, \Graphpinator\Parser\Fragment\Fragment> $fragments,
    ) {
        parent::__construct($id, $location);
    }

    public function getOperations(): dict<string, \Graphpinator\Parser\Operation\Operation> {
        return $this->operations;
    }

    public function getFragments(): dict<string, \Graphpinator\Parser\Fragment\Fragment> {
        return $this->fragments;
    }
}
