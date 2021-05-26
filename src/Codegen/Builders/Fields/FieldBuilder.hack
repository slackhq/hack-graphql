namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{C, Str, Vec};
use type Facebook\HackCodegen\{HackBuilder, HackBuilderValues};

/**
 * Base builder for constructing GraphQL fields.
 */
abstract class FieldBuilder {

    abstract const type TField as shape(
        'name' => string,
        'output_type' => shape('type' => string, ?'needs_await' => bool),
        'declaring_type' => string,
        ...
    );

    public function getName(): string {
        return $this->data['name'];
    }

    // Constructors

    public function __construct(protected this::TField $data) {}

    /**
     * Construct a GraphQL field from a Hack method.
     */
    public static function fromReflectionMethod(
        \Slack\GraphQL\Field $field,
        \ReflectionMethod $rm,
        bool $is_root_field = false,
    ): FieldBuilder {
        $data = shape(
            'name' => $field->getName(),
            'method_name' => $rm->getName(),
            'declaring_type' => $rm->getDeclaringClass()->getName(),
            'is_root_field' => $is_root_field,
            'output_type' => output_type(
                $rm->getReturnTypeText(),
                $rm->getAttributeClass(\Slack\GraphQL\KillsParentOnException::class) is nonnull,
            ),
            'parameters' => Vec\map(
                $rm->getParameters(),
                $param ==> {
                    $data = shape(
                        'name' => $param->getName(),
                        'type' => $param->getTypeText(),
                        'is_optional' => $param->isOptional(),
                    );
                    if ($param->isOptional()) {
                        $data['default_value'] = $param->getDefaultValueText();
                    }
                    return $data;
                },
            ),
        );

        if (returns_connection_type($rm)) {
            return new ConnectionFieldBuilder($data);
        } else {
            return new MethodFieldBuilder($data);
        }
    }

    /**
     * Construct a GraphQL field from a shape field.
     */
    public static function fromShapeField<T>(string $name, string $declaring_type, TypeStructure<T> $ts): FieldBuilder {
        return new ShapeFieldBuilder(shape(
            'name' => $name,
            'output_type' => output_type(type_structure_to_type_alias($ts), false),
            'declaring_type' => $declaring_type,
            'is_optional' => Shapes::idx($ts, 'optional_shape_field') ?? false,
        ));
    }

    /**
     * Construct a top-level GraphQL field.
     */
    public static function forRootField(\Slack\GraphQL\Field $field, \ReflectionMethod $rm): FieldBuilder {
        return FieldBuilder::fromReflectionMethod($field, $rm, true);
    }

    // Codegen

    /**
     * Get arguments definitions for this GQL field.
     */
    abstract protected function getArgumentDefinitions(): vec<Parameter>;

    /**
     * Generate the body of the resolver callback.
     */
    abstract protected function generateResolverBody(HackBuilder $hb): void;

    public function addGetFieldDefinitionCase(HackBuilder $hb): void {
        $hb->addCase($this->data['name'], HackBuilderValues::export());

        $hb->addLine('return new GraphQL\\FieldDefinition(')->indent();

        // Field name
        $name_literal = \var_export($this->data['name'], true);
        $hb->addLinef('%s,', $name_literal);

        // Field return type
        $type_info = $this->data['output_type'];
        $hb->addLinef('%s,', $type_info['type']);

        // Argument Definitions
        $this->generateArgumentDefinitions($hb);

        // Resolver
        $hb->add('async ($parent, $args, $vars) ==> ');
        $this->generateResolverBody($hb);
        $hb->addLine(',');

        // End of new GraphQL\FieldDefinition(
        $hb->unindent()->addLine(');');
        $hb->unindent();
    }

    private function generateArgumentDefinitions(HackBuilder $hb): void {
        $argument_defintions = $this->getArgumentDefinitions();
        if ($argument_defintions) {
            $hb->addLine('dict[')->indent();
            foreach ($argument_defintions as $param) {
                $argument_name = \var_export($param['name'], true);
                $hb->addLinef('%s => shape(', $argument_name)->indent();

                $hb->addLinef("'name' => %s,", $argument_name);

                $type = input_type($param['type']);
                $hb->addLinef("'type' => %s,", $type);

                $default_value = $param['default_value'] ?? null;
                if ($default_value is nonnull) {
                    $hb->addLinef("'defaultValue' => %s,", \var_export($default_value, true));
                }

                $hb->unindent()->addLine('),');
            }
            $hb->unindent()->addLine('],');
        } else {
            $hb->addLine('dict[],');
        }
    }
}
