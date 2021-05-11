namespace Slack\GraphQL\Codegen;

use namespace Slack\GraphQL\Types;
use namespace Facebook\HHAST;
use namespace HH\Lib\{Str, Vec, C};
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

function hb(HackCodegenFactory $cg): HackBuilder {
    return new HackBuilder($cg->getConfig());
}

interface GeneratableObjectType {
    public function generateObjectType(HackCodegenFactory $cg): CodegenClass;
}

abstract class BaseObject<T as Field> implements GeneratableObjectType {
    protected vec<T> $fields;

    protected function generateGetFieldDefinition(HackCodegenFactory $cg): CodegenMethod {
        $method = $cg->codegenMethod('getFieldDefinition')
            ->setPublic()
            ->setReturnType('GraphQL\\IFieldDefinition<this::THackType>')
            ->addParameter('string $field_name');

        $hb = hb($cg);
        $hb->startSwitch('$field_name')
            ->addCaseBlocks(
                $this->fields,
                ($field, $hb) ==> {
                    $field->addGetFieldDefinitionCase($hb);
                    $hb->unindent();
                },
            )
            ->addDefault()
            ->addLine("throw new \Exception('Unknown field: '.\$field_name);")
            ->endDefault()
            ->endSwitch();

        $method->setBody($hb->getCode());

        return $method;
    }
}

class Query extends BaseObject<QueryField> {
    public function __construct(protected vec<QueryField> $fields) {}

    public function generateObjectType(HackCodegenFactory $cg): CodegenClass {
        $class = $cg->codegenClass('Query');

        $hack_type_constant = $cg->codegenClassConstant('THackType')
            ->setType('type')
            ->setValue('GraphQL\\Root', HackBuilderValues::literal());

        $class->addConstant($hack_type_constant);
        $class->addConstant($cg->codegenClassConstant('NAME')->setValue('Query', HackBuilderValues::export()));

        $class->addMethod($this->generateGetFieldDefinition($cg));

        return $class;
    }
}

class Mutation extends BaseObject<MutationField> {
    public function __construct(protected vec<MutationField> $fields) {}

    public function generateObjectType(HackCodegenFactory $cg): CodegenClass {
        $class = $cg->codegenClass('Mutation');

        $hack_type_constant = $cg->codegenClassConstant('THackType')
            ->setType('type')
            ->setValue('GraphQL\\Root', HackBuilderValues::literal());

        $class->addConstant($hack_type_constant);
        $class->addConstant($cg->codegenClassConstant('NAME')->setValue('Mutation', HackBuilderValues::export()));

        $class->addMethod($this->generateGetFieldDefinition($cg));

        return $class;
    }
}

abstract class CompositeType<T as \Slack\GraphQL\__Private\CompositeType> extends BaseObject<Field> {
    public function __construct(
        private HHAST\ClassishDeclaration $class_decl,
        private T $composite_type,
        private \ReflectionClass $reflection_class,
        protected vec<Field> $fields,
    ) {}

    public function getFields(): vec<Field> {
        return $this->fields;
    }

    public function generateObjectType(HackCodegenFactory $cg): CodegenClass {
        $class = $cg->codegenClass($this->composite_type->getType());

        $hack_type_constant = $cg->codegenClassConstant('THackType')
            ->setType('type')
            ->setValue('\\'.$this->class_decl->getName()->getText(), HackBuilderValues::literal());

        $class->addConstant($hack_type_constant);
        $class->addConstant(
            $cg->codegenClassConstant('NAME')->setValue($this->composite_type->getType(), HackBuilderValues::export())
        );

        $class->addMethod($this->generateGetFieldDefinition($cg));

        return $class;
    }
}

class GQLInterface extends CompositeType<\Slack\GraphQL\InterfaceType> {}

class Object extends CompositeType<\Slack\GraphQL\ObjectType> {}

class Field {
    public function __construct(
        protected HHAST\ClassishDeclaration $class_decl,
        protected HHAST\MethodishDeclaration $method_decl,
        protected \ReflectionMethod $reflection_method,
        protected \Slack\GraphQL\Field $graphql_field,
    ) {}

    final public function addGetFieldDefinitionCase(HackBuilder $hb): void {
        $hb->addCase($this->graphql_field->getName(), HackBuilderValues::export());

        $return_prefix = '';
        if ($this->reflection_method->getReturnTypeText() |> Str\starts_with($$, 'HH\Awaitable')) {
            $return_prefix = 'await ';
        }

        $hb->addLine('return new GraphQL\\FieldDefinition(')->indent();

        // Field return type
        $hb->addLinef('%s::nullable(),', $this->getGraphQLType());

        // Arguments
        $hb->addf(
            'async ($parent, $args, $vars) ==> %s%s%s(',
            $return_prefix,
            $this->getMethodCallPrefix(),
            $this->method_decl->getFunctionDeclHeader()->getName()->getText(),
        );
        $args = $this->getArgumentInvocationStrings();
        if (!C\is_empty($args)) {
            $hb->newLine()->indent();
            foreach ($args as $arg) {
                $hb->addLinef('%s,', $arg);
            }
            $hb->unindent();
        }
        $hb->addLine('),');

        // End of new GraphQL\FieldDefinition(
        $hb->unindent()->addLine(');');
    }

    protected function getMethodCallPrefix(): string {
        return '$parent->';
    }

    final protected function getGraphQLType(): string {
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
                return \Slack\GraphQL\Types\StringOutputType::class
                    |> Str\strip_prefix($$, 'Slack\\GraphQL\\');
            case 'int':
                return \Slack\GraphQL\Types\IntOutputType::class
                    |> Str\strip_prefix($$, 'Slack\\GraphQL\\');
            case 'bool':
                return \Slack\GraphQL\Types\BooleanOutputType::class
                    |> Str\strip_prefix($$, 'Slack\\GraphQL\\');
            default:
                // TODO: this doesn't handle custom types, how do we make this
                // better?
                $rc = new \ReflectionClass($simple_return_type);
                $graphql_object = $rc->getAttributeClass(\Slack\GraphQL\ObjectType::class) ?? $rc->getAttributeClass(\Slack\GraphQL\InterfaceType::class);
                if ($graphql_object is null) {
                    throw new \Error(
                        'GraphQL\Field return types must be scalar or be classes annnotated with <<GraphQL\Object(...)>> or <<GraphQL\GQLInterface(...)>>',
                    );
                }

                return $graphql_object->getType();
        }
    }

    public function hasArguments(): bool {
        return $this->reflection_method->getNumberOfParameters() > 0;
    }

    protected function getArgumentInvocationStrings(): vec<string> {
        $invocations = vec[];
        foreach ($this->reflection_method->getParameters() as $index => $param) {
            $invocations[] = Str\format(
                '%s->coerceNode($args[%s]->getValue(), $vars)',
                self::hackTypeToInputTypeFactoryCall($param->getTypeText()),
                \var_export($param->getName(), true),
            );
        }
        return $invocations;
    }

    /**
     * Examples:
     *   int       -> IntInputType::nonNullable()
     *   ?int      -> IntInputType::nullable()
     *   ?vec<int> -> IntInputType::nonNullable()->nullableListOf()
     */
    private static function hackTypeToInputTypeFactoryCall(string $hack_type, bool $nullable = false): string {
        if (Str\starts_with($hack_type, '?')) {
            return self::hackTypeToInputTypeFactoryCall(Str\strip_prefix($hack_type, '?'), true);
        }
        if (Str\starts_with($hack_type, 'HH\vec<')) {
            return
                self::hackTypeToInputTypeFactoryCall(
                    Str\strip_prefix($hack_type, 'HH\vec<') |> Str\strip_suffix($$, '>'),
                ).
                ($nullable ? '->nullableListOf()' : '->nonNullableListOf()');
        }
        switch ($hack_type) {
            case 'HH\int':
                $class = Types\IntInputType::class;
                break;
            case 'HH\string':
                $class = Types\StringInputType::class;
                break;
            case 'HH\bool':
                $class = Types\BooleanInputType::class;
                break;
            default:
                invariant_violation('not yet implemented');
        }
        return
            Str\strip_prefix($class, 'Slack\\GraphQL\\').
            ($nullable ? '::nullable()' : '::nonNullable()');
    }
}

class QueryField extends Field {
    <<__Override>>
    protected function getMethodCallPrefix(): string {
        return '\\'.$this->class_decl->getName()->getText().'::';
    }
}

class MutationField extends QueryField {}

final class Generator {
    private HackCodegenFactory $cg;
    private bool $has_mutations = false;

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
            ->useNamespace('Slack\\GraphQL')
            ->useNamespace('Slack\\GraphQL\\Types')
            ->useNamespace('HH\\Lib\\Dict')
            ->addClass($this->generateSchemaType($this->cg));

        foreach ($objects as $object) {
            $class = $object->generateObjectType($this->cg)
                ->setIsFinal(true)
                ->setExtendsf('\%s', \Slack\GraphQL\Types\ObjectType::class);
            $file->addClass($class);
        }

        return $file;
    }

    private function generateSchemaType(HackCodegenFactory $cg): CodegenClass {
        $class = $cg->codegenClass('Schema')
            ->setIsAbstract(true)
            ->setIsFinal(true)
            ->setExtendsf('\%s', \Slack\GraphQL\BaseSchema::class);

        $class->addMethod(
            $this->generateSchemaResolveOperationMethod($cg, \Graphpinator\Tokenizer\OperationType::QUERY),
        );

        if ($this->has_mutations) {
            $class
                ->addMethod(
                    $this->generateSchemaResolveOperationMethod($cg, \Graphpinator\Tokenizer\OperationType::MUTATION),
                );

            $mutation_const = $cg->codegenClassConstant('SUPPORTS_MUTATIONS')
                ->setType('bool')
                ->setValue(true, HackBuilderValues::export());

            $class->addConstant($mutation_const);
        }

        return $class;
    }

    private function generateSchemaResolveOperationMethod(
        HackCodegenFactory $cg,
        \Graphpinator\Tokenizer\OperationType $operation_type,
    ): CodegenMethod {
        switch ($operation_type) {
            case \Graphpinator\Tokenizer\OperationType::QUERY:
                $method_name = 'resolveQuery';
                $root_type = 'Query::nullable()';
                break;
            case \Graphpinator\Tokenizer\OperationType::MUTATION:
                $method_name = 'resolveMutation';
                $root_type = 'Mutation::nullable()';
                break;
            case \Graphpinator\Tokenizer\OperationType::SUBSCRIPTION:
                invariant(false, 'TODO: support subscription');
        }

        $resolve_method = $cg->codegenMethod($method_name)
            ->setPublic()
            ->setIsStatic(true)
            ->setIsAsync(true)
            ->setReturnType('Awaitable<GraphQL\\ValidFieldResult>')
            ->addParameterf('\%s $operation', \Graphpinator\Parser\Operation\Operation::class)
            ->addParameterf('\%s $variables', \Slack\GraphQL\__Private\Variables::class);

        $hb = hb($cg)->addReturnf('await %s->resolveAsync(new GraphQL\\Root(), $operation, $variables)', $root_type);

        $resolve_method->setBody($hb->getCode());

        return $resolve_method;
    }

    private async function collectObjects<T as Field>(string $from_path): Awaitable<vec<GeneratableObjectType>> {
        $script = await HHAST\from_file_async(HHAST\File::fromPath($from_path));

        $interfaces = dict[];
        $objects = vec[];
        $query_fields = vec[];
        $mutation_fields = vec[];
        foreach ($script->getDescendantsOfType(HHAST\ClassishDeclaration::class) as $class_decl) {
            if ($class_decl->hasAttribute()) {
                $rc = new \ReflectionClass($class_decl->getName()->getText());

                $graphql_interface = $rc->getAttributeClass(\Slack\GraphQL\InterfaceType::class);
                if ($graphql_interface is nonnull) {
                    $fields = $this->collectObjectFields($class_decl);
                    $object = new GQLInterface($class_decl, $graphql_interface, $rc, $fields);
                    $interfaces[$class_decl->getName()->getText()] = $object;
                    $objects[] = $object;
                }

                $graphql_object = $rc->getAttributeClass(\Slack\GraphQL\ObjectType::class);
                if ($graphql_object is nonnull) {
                    $fields = vec[];

                    // Add interface fields.
                    // This feels a bit hacky - is there a better way?
                    foreach ($rc->getInterfaceNames() as $interface_name) {
                        $interface = $interfaces[$interface_name];
                        $fields = Vec\concat($fields, $interface->getFields());
                    }

                    $fields = Vec\concat($fields, $this->collectObjectFields($class_decl));

                    $objects[] = new Object($class_decl, $graphql_object, $rc, $fields);
                }
            }

            foreach ($class_decl->getDescendantsOfType(HHAST\MethodishDeclaration::class) as $method_decl) {
                // TODO: right now these need to be static, not sure how we
                // would do it otherwise. Should validate that here.
                if (!$method_decl->hasAttribute()) continue;

                $method_name = $method_decl->getFunctionDeclHeader()->getName()->getText();
                $rm = new \ReflectionMethod($class_decl->getName()->getText(), $method_name);
                $query_root_field = $rm->getAttributeClass(\Slack\GraphQL\QueryRootField::class);
                if ($query_root_field is nonnull) {
                    $query_fields[] = new QueryField($class_decl, $method_decl, $rm, $query_root_field);
                    continue;
                }

                // TODO: maybe throw an error if a field is tagged with both query + mutation field?
                $mutation_root_field = $rm->getAttributeClass(\Slack\GraphQL\MutationRootField::class);
                if ($mutation_root_field is nonnull) {
                    $this->has_mutations = true;

                    $mutation_fields[] = new MutationField($class_decl, $method_decl, $rm, $mutation_root_field);
                }
            }
        }

        // TODO: throw an error if no query fields?

        if (!C\is_empty($query_fields)) {
            $top_level_objects = vec[new Query($query_fields)];

            if (!C\is_empty($mutation_fields)) {
                $top_level_objects[] = new Mutation($mutation_fields);
            }

            $objects = Vec\concat($top_level_objects, $objects);
        }

        return $objects;
    }

    private function collectObjectFields(HHAST\ClassishDeclaration $class_decl): vec<Field> {
        $fields = vec[];
        foreach ($class_decl->getDescendantsOfType(HHAST\MethodishDeclaration::class) as $method_decl) {
            if (!$method_decl->hasAttribute()) continue;

            $method_name = $method_decl->getFunctionDeclHeader()->getName()->getText();
            $rm = new \ReflectionMethod($class_decl->getName()->getText(), $method_name);
            $graphql_field = $rm->getAttributeClass(\Slack\GraphQL\Field::class);
            if ($graphql_field is null) continue;

            $fields[] = new Field($class_decl, $method_decl, $rm, $graphql_field);
        }
        return $fields;
    }
}
