


namespace Slack\GraphQL\Codegen;
use type Facebook\HackCodegen\{HackBuilder};

final class IntrospectSchemaFieldBuilder extends FieldBuilder {
    public function __construct() {
        parent::__construct(shape(
            'name' => '__schema',
            'output_type' => shape('type' => '__Schema::nullableOutput()'),
        ));
    }

    <<__Override>>
    protected function generateResolverBody(HackBuilder $hb): void {
        $hb->add('new Schema()');
    }

    <<__Override>>
    protected function getArgumentDefinitions(): vec<Parameter> {
        return vec[];
    }
}
