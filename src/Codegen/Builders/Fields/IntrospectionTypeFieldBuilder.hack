


namespace Slack\GraphQL\Codegen;
use type Facebook\HackCodegen\{HackBuilder};

final class IntrospectTypeFieldBuilder extends MethodFieldBuilder {

    public function __construct() {
        parent::__construct(shape(
            'name' => '__type',
            'method_name' => '_',
            'output_type' => shape('type' => '__Type::nullableOutput()'),
            'root_field_for_type' => 'Schema',
            'parameters' => vec[
                shape('name' => 'name', 'type' => 'HH\string', 'is_optional' => false),
            ],
            'directives' => vec[],
        ));
    }
    <<__Override>>
    protected function generateResolverBody(HackBuilder $hb): void {
        $hb->add('(new Schema())->getIntrospectionType(')
            ->newLine();

        $this->generateParametersInvocation($hb);
        $hb->add(')');
    }
}
