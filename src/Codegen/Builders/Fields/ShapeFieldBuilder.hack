


namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{C, Str, Vec};
use type Facebook\HackCodegen\{HackBuilder, HackBuilderValues};

/**
 * Build a GraphQL field from a shape field.
 *
 * In general, call `FieldBuilder::fromShapeField` instead of instantiating this directly.
 */
final class ShapeFieldBuilder extends FieldBuilder {
    <<__Override>>
    protected function getArgumentDefinitions(): vec<Parameter> {
        return vec[];
    }

    <<__Override>>
    protected function generateResolverBody(HackBuilder $hb): void {
        $name_literal = \var_export($this->data['name'], true);
        $hb->addf('$parent[%s]%s', $name_literal, Shapes::idx($this->data, 'is_optional', false) ? ' ?? null' : '');
    }
}
