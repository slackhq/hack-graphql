namespace Graphpinator\Normalizer\Directive;

/**
 * @method \Graphpinator\Normalizer\Directive\Directive current() : object
 * @method \Graphpinator\Normalizer\Directive\Directive offsetGet($offset) : object
 */
final class DirectiveSet extends \Infinityloop\Utils\ObjectSet<Directive> {

    public function applyVariables(\Graphpinator\Normalizer\VariableValueSet $variables): void {
        foreach ($this as $directive) {
            $directive->applyVariables($variables);
        }
    }
}
