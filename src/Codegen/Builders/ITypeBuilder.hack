namespace Slack\GraphQL\Codegen;

use type Facebook\HackCodegen\{CodegenClass, HackCodegenFactory};

/**
 * A builder which creates a GraphQL type representing a Hack type,
 * where a HackType is an interface, object, enum, etc.
 */
interface ITypeBuilder {
    public function getGraphQLType(): string;
    public function build(HackCodegenFactory $cg): CodegenClass;
    // TODO: make this non nullable
    public function buildIntrospectionClass(HackCodegenFactory $cg): ?CodegenClass;
}
