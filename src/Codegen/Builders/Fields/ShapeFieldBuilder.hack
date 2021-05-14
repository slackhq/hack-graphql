namespace Slack\GraphQL\Codegen;

use type Facebook\HackCodegen\{HackBuilder, HackBuilderValues};

class ShapeFieldBuilder<T> implements IFieldBuilder {
    public function __construct(private string $field_name, private TypeStructure<T> $type_structure) {}

    public function addGetFieldDefinitionCase(HackBuilder $hb): void {
        $name_literal = \var_export($this->field_name, true);

        $hb->addCase($name_literal, HackBuilderValues::literal());
        $hb->addLine('return new GraphQL\\FieldDefinition(')->indent();

        // Field return type
        $type_info = output_type(type_structure_to_type_alias($this->type_structure), false);
        $hb->addLinef('%s,', $type_info['type']);

        $hb->addf(
            'async ($parent, $args, $vars) ==> $parent[%s]%s',
            $name_literal,
            Shapes::idx($this->type_structure, 'optional_shape_field', false) ? ' ?? null' : '',
        );
        $hb->addLine(',');

        // End of new GraphQL\FieldDefinition(
        $hb->unindent()->addLine(');');
        $hb->unindent();
    }
}
