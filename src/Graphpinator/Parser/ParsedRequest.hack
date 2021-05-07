namespace Graphpinator\Parser;

final class ParsedRequest {

    public function __construct(
        private dict<string, \Graphpinator\Parser\Operation\Operation> $operations,
        private dict<string, \Graphpinator\Parser\Fragment\Fragment> $fragments,
    ) {}

    public function getOperations(): dict<string, \Graphpinator\Parser\Operation\Operation> {
        return $this->operations;
    }

    public function getFragments(): dict<string, \Graphpinator\Parser\Fragment\Fragment> {
        return $this->fragments;
    }
}
