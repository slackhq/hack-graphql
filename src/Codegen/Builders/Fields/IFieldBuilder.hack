namespace Slack\GraphQL\Codegen;

use type Facebook\HackCodegen\HackBuilder;

interface IFieldBuilder {
    public function addGetFieldDefinitionCase(HackBuilder $hb): void;
    public function getName(): string;
}
