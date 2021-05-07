namespace Graphpinator\Directive\Spec;

final class DeprecatedDirective
    extends \Graphpinator\Directive\Directive
    implements
        \Graphpinator\Directive\Contract\FieldDefinitionLocation,
        \Graphpinator\Directive\Contract\EnumItemLocation {
    const NAME = 'deprecated';
    const DESCRIPTION = 'Built-in deprecated directive.';

    public function validateFieldUsage(
        \Graphpinator\Field\Field $field,
        \Graphpinator\Value\ArgumentValueSet $arguments,
    ): bool {
        return true;
    }

    public function validateVariance(
        ?\Graphpinator\Value\ArgumentValueSet $biggerSet,
        ?\Graphpinator\Value\ArgumentValueSet $smallerSet,
    ): void {
        // nothing here
    }

    public function resolveFieldDefinitionStart(
        \Graphpinator\Value\ArgumentValueSet $arguments,
        \Graphpinator\Value\ResolvedValue $parentValue,
    ): void {
        // nothing here
    }

    public function resolveFieldDefinitionBefore(
        \Graphpinator\Value\ArgumentValueSet $arguments,
        \Graphpinator\Value\ResolvedValue $parentValue,
        \Graphpinator\Value\ArgumentValueSet $fieldArguments,
    ): void {
        // nothing here
    }

    public function resolveFieldDefinitionAfter(
        \Graphpinator\Value\ArgumentValueSet $arguments,
        \Graphpinator\Value\ResolvedValue $resolvedValue,
        \Graphpinator\Value\ArgumentValueSet $fieldArguments,
    ): void {
        // nothing here
    }

    public function resolveFieldDefinitionValue(
        \Graphpinator\Value\ArgumentValueSet $arguments,
        \Graphpinator\Value\FieldValue $fieldValue,
    ): void {
        // nothing here
    }

    protected function getFieldDefinition(): \Graphpinator\Argument\ArgumentSet {
        return new \Graphpinator\Argument\ArgumentSet(dict[
            'reason' => new \Graphpinator\Argument\Argument('reason', \Graphpinator\Container\Container::String()),
        ]);
    }
}
