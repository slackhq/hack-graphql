namespace Graphpinator\Directive\Spec;

final class SkipDirective
    extends \Graphpinator\Directive\Directive
    implements \Graphpinator\Directive\Contract\FieldLocation {
    const NAME = 'skip';
    const DESCRIPTION = 'Built-in skip directive.';

    public function validateFieldUsage(
        \Graphpinator\Field\Field $field,
        \Graphpinator\Value\ArgumentValueSet $arguments,
    ): bool {
        return true;
    }

    public function resolveFieldBefore(\Graphpinator\Value\ArgumentValueSet $arguments): string {
        return $arguments->offsetGet('if')->getValue()->getRawValue()
            ? \Graphpinator\Directive\FieldDirectiveResult::SKIP
            : \Graphpinator\Directive\FieldDirectiveResult::NONE;
    }

    public function resolveFieldAfter(
        \Graphpinator\Value\ArgumentValueSet $arguments,
        \Graphpinator\Value\FieldValue $fieldValue,
    ): string {
        return \Graphpinator\Directive\FieldDirectiveResult::NONE;
    }

    protected function getFieldDefinition(): \Graphpinator\Argument\ArgumentSet {
        return new \Graphpinator\Argument\ArgumentSet(dict[
            'if' => new \Graphpinator\Argument\Argument('if', \Graphpinator\Container\Container::Boolean()->notNull()),
        ]);
    }
}
