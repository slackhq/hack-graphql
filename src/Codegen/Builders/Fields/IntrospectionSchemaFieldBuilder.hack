


namespace Slack\GraphQL\Codegen;
use type Facebook\HackCodegen\{HackBuilder};

final class IntrospectSchemaFieldBuilder extends FieldBuilder {
    const type TField = shape(
        'name' => string,
        'output_type' => shape('type' => string, ?'needs_await' => bool),
        'directives' => vec<string>,
        ...
    );

    public function __construct() {
        parent::__construct(shape(
            'name' => '__schema',
            'output_type' => shape('type' => '__Schema::nullableOutput()'),
            'directives' => vec[],
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
