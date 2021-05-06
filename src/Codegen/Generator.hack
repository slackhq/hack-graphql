namespace Slack\GraphQL\Codegen;

use namespace Facebook\HHAST;
use namespace HH\Lib\{Str, Vec};
use type Facebook\HackCodegen\{
    CodegenFile,
    CodegenFileType,
    CodegenClass,
    CodegenGeneratedFrom,
    CodegenMethod,
    HackBuilder,
    HackCodegenFactory,
    HackCodegenConfig,
    IHackCodegenConfig,
    HackBuilderValues,
};

// - [x] support searching for classes and printing out the name
// - [ ] support searching for methods tagged with GraphQLField
// - [ ] support inspecting the method args for any method tagged GraphQLField
// - [ ] support codegening a class for any GraphQLObject
// - [ ] support codegening the resolver

// collect the objects
// - name of the graphql object
// - name of the class it decorates
// - fields in the object

// collect the fields in an object
// - name of the field
// - method + arg info for the method

function hb(HackCodegenFactory $cg): HackBuilder {
    return new HackBuilder($cg->getConfig());
}


class Object {
    public function __construct(
        private HHAST\ClassishDeclaration $class_decl,
        private \Slack\GraphQL\Object $graphql_object,
        private \ReflectionClass $reflection_class,
        private vec<Field> $fields,
    ) {}

    public function generateObjectType(HackCodegenFactory $cg): CodegenClass {
        $class = $cg->codegenClass($this->graphql_object->getType());

        $class->setExtendsf('\%s', \Slack\GraphQL\Types\ObjectType::class);

        $hack_type_constant = $cg->codegenClassConstant('THackType')
            ->setType('type')
            ->setValue('\\'.$this->class_decl->getName()->getText(), HackBuilderValues::literal());

        $class->addConstant($hack_type_constant);

        $class
            ->addMethod($this->generateResolveField($cg))
            ->addMethod($this->generateResolveType($cg));

        return $class;
    }

    private function generateResolveField(HackCodegenFactory $cg): CodegenMethod {
        $method = $cg->codegenMethod('resolveField')
            ->setIsAsync(true)
            ->setIsStatic(true)
            ->setPublic()
            ->setReturnType('Awaitable<mixed>')
            ->addParameter('string $field_name')
            ->addParameter('self::THackType $resolved_parent');

        $hb = hb($cg);
        $hb->startSwitch('$field_name')
            ->addCaseBlocks(
                $this->fields,
                ($field, $hb) ==> {
                    $field->addResolveFieldCase($hb);
                },
            )
            ->addDefault()
            ->addLine("throw new \Error('Unknown field: '.\$field_name);")
            ->endDefault()
            ->endSwitch();

        $method->setBody($hb->getCode());

        return $method;
    }

    private function generateResolveType(HackCodegenFactory $cg): CodegenMethod {
        $method = $cg->codegenMethod('resolveType')
            ->setIsStatic(true)
            ->setPublic()
            ->setReturnTypef('\%s', \Slack\GraphQL\Types\BaseType::class)
            ->addParameter('string $field_name');

        $hb = hb($cg);
        $hb->startSwitch('$field_name')
            ->addCaseBlocks(
                $this->fields,
                ($field, $hb) ==> {
                    $field->addResolveTypeCase($hb);
                },
            )
            ->addDefault()
            ->addLine("throw new \Error('Unknown field: '.\$field_name);")
            ->endDefault()
            ->endSwitch();

        $method->setBody($hb->getCode());

        return $method;
    }


}

class Field {
    public function __construct(
        private HHAST\ClassishDeclaration $class_decl,
        private HHAST\MethodishDeclaration $method_decl,
        private \ReflectionMethod $reflection_method,
        private \Slack\GraphQL\Field $graphql_field,
    ) {}

    public function addResolveFieldCase(HackBuilder $hb): void {
        $hb->addCase($this->graphql_field->getName(), HackBuilderValues::export());

        $return_prefix = '';
        if ($this->reflection_method->getReturnTypeText() |> Str\starts_with($$, 'HH\Awaitable')) {
            $return_prefix = 'await ';
        }

        $hb->returnCasef(
            '%s$resolved_parent->%s()',
            $return_prefix,
            $this->method_decl->getFunctionDeclHeader()->getName()->getText(),
        );
    }

    public function addResolveTypeCase(HackBuilder $hb): void {
        $graphql_type = $this->getGraphQLType();
        $hb
            ->addCase($this->graphql_field->getName(), HackBuilderValues::export())
            ->returnCasef('new %s()', $graphql_type);
    }

    private function getGraphQLType(): string {
        // TODO: must be a better way to do this
        $simple_return_type = $this->method_decl
            ->getFunctionDeclHeader()
            ->getChildren()['type']->getDescendantsOfType(HHAST\SimpleTypeSpecifier::class)
            |> Vec\map($$, $node ==> $node->getCode())
            |> Vec\filter_nulls($$)
            |> Str\join($$, '')
            |> Str\trim($$);

        switch ($simple_return_type) {
            case 'string':
                return \Slack\GraphQL\Types\StringType::class
                    |> Str\format('\%s', $$);
            case 'int':
                return \Slack\GraphQL\Types\IntType::class
                    |> Str\format('\%s', $$);
            default:
                $rc = new \ReflectionClass($simple_return_type);
                $graphql_object = $rc->getAttributeClass(\Slack\GraphQL\Object::class);
                if ($graphql_object is null) {
                    throw new \Error(
                        'GraphQL\Field return types must be scalar or be classes annnotated with <<GraphQL\Object(...)>>',
                    );
                }

                return $graphql_object->getType();
        }
    }

}

final class Generator {
    private HackCodegenFactory $cg;

    public function __construct(private ?IHackCodegenConfig $hackCodegenConfig = null) {
        $this->cg = new HackCodegenFactory($hackCodegenConfig ?? new HackCodegenConfig());
    }

    public async function generate(string $from_path, string $to_path): Awaitable<CodegenFile> {
        $objects = await $this->collectObjects($from_path);

        $file = $this->cg
            ->codegenFile($to_path)
            ->setDoClobber(true)
            ->setGeneratedFrom($this->cg->codegenGeneratedFromScript())
            ->setFileType(CodegenFileType::DOT_HACK)
            ->setNamespace('Slack\GraphQL\Test\Generated');

        foreach ($objects as $object) {
            $class = $object->generateObjectType($this->cg);
            $file->addClass($class);
        }

        $file->save();
        return $file;
    }

    private async function collectObjects(string $from_path): Awaitable<vec<Object>> {
        $script = await HHAST\from_file_async(HHAST\File::fromPath($from_path));

        $objects = vec[];
        foreach ($script->getDescendantsOfType(HHAST\ClassishDeclaration::class) as $class_decl) {
            if (!$class_decl->hasAttribute()) continue;

            $rc = new \ReflectionClass($class_decl->getName()->getText());
            $graphql_object = $rc->getAttributeClass(\Slack\GraphQL\Object::class);
            if ($graphql_object is nonnull) {

                $fields = vec[];
                foreach ($class_decl->getDescendantsOfType(HHAST\MethodishDeclaration::class) as $method_decl) {
                    if (!$method_decl->hasAttribute()) continue;

                    $method_name = $method_decl->getFunctionDeclHeader()->getName()->getText();
                    $rm = new \ReflectionMethod($class_decl->getName()->getText(), $method_name);
                    $graphql_field = $rm->getAttributeClass(\Slack\GraphQL\Field::class);
                    if ($graphql_field is null) continue;

                    $fields[] = new Field($class_decl, $method_decl, $rm, $graphql_field);
                }

                $objects[] = new Object($class_decl, $graphql_object, $rc, $fields);
            }
        }

        return $objects;
    }
}
