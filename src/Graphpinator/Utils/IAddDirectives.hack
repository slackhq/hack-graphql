namespace Graphpinator\Utils;

interface IAddDirectives<T> {
    public function addDirective(
        T $directive,
        \Graphpinator\Argument\ArgumentSet $arguments = new \Graphpinator\Argument\ArgumentSet(),
    ): this;
}
