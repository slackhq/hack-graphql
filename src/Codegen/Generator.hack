namespace Slack\GraphQL\Codegen;

use namespace Slack\GraphQL\Types;
use namespace Facebook\DefinitionFinder;
use namespace HH\Lib\{Str, Vec, C, Dict};
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

final class Generator {
    private HackCodegenFactory $cg;
    private bool $has_mutations = false;

    const type TGeneratorConfig = shape(
        'output_directory' => string,
        'namespace' => string,
        ?'codegen_config' => IHackCodegenConfig,
    );

    private function __construct(private DefinitionFinder\BaseParser $parser, private self::TGeneratorConfig $config) {
        $this->cg = new HackCodegenFactory($config['codegen_config'] ?? new HackCodegenConfig());
    }

    public static async function forPath(string $path, self::TGeneratorConfig $config): Awaitable<void> {
        $defs = await DefinitionFinder\TreeParser::fromPathAsync($path);
        $gen = new self($defs, $config);
        await $gen->generate();
    }

    public static async function forFile(string $filename, self::TGeneratorConfig $config): Awaitable<void> {
        $defs = await DefinitionFinder\FileParser::fromFileAsync($filename);
        $gen = new self($defs, $config);
        await $gen->generate();
    }

    public async function generate(): Awaitable<void> {
        $objects = await $this->collectObjects();

        self::removeDirectory($this->config['output_directory']);
        \mkdir($this->config['output_directory']);

        $input_types = BUILTIN_INPUT_TYPES;
        $output_types = BUILTIN_OUTPUT_TYPES;

        foreach ($objects as $object) {
            $class = $object->build($this->cg);
            $this->generateFile($class);
            if ($object is InputTypeBuilder<_>) {
                $input_types = self::add($input_types, $object->getGraphQLType(), $class->getName());
            } elseif ($object is OutputTypeBuilder<_>) {
                $output_types = self::add($output_types, $object->getGraphQLType(), $class->getName());
            }
        }

        $this->generateFile($this->generateSchemaType($this->cg, $input_types, $output_types));
    }

    private static function removeDirectory(string $directory): void {
        $handles = new \RecursiveIteratorIterator(
            new \RecursiveDirectoryIterator($directory, \RecursiveDirectoryIterator::SKIP_DOTS),
            \RecursiveIteratorIterator::CHILD_FIRST,
        );

        foreach ($handles as $handle) {
            if ($handle->isDir()) {
                \rmdir($handle->getRealPath());
            } else {
                \unlink($handle->getRealPath());
            }
        }

        \rmdir($directory);
    }

    private function generateFile(CodegenClass $class): void {
        $this->cg
            ->codegenFile($this->config['output_directory'].'/'.$class->getName().'.hack')
            ->setDoClobber(true)
            ->setGeneratedFrom($this->cg->codegenGeneratedFromScript('vendor/bin/hacktest'))
            ->setFileType(CodegenFileType::DOT_HACK)
            ->setNamespace($this->config['namespace'])
            ->useNamespace('Slack\\GraphQL')
            ->useNamespace('Slack\\GraphQL\\Types')
            ->useNamespace('HH\\Lib\\{C, Dict}')
            ->addClass($class)
            ->save();
    }

    private static function add(dict<string, string> $dict, string $key, string $value): dict<string, string> {
        invariant(!C\contains_key($dict, $key), 'Conflicting entry for "%s": "%s" vs "%s"', $key, $dict[$key], $value);
        $dict[$key] = $value;
        return $dict;
    }

    private function generateSchemaType(
        HackCodegenFactory $cg,
        dict<string, string> $input_types,
        dict<string, string> $output_types,
    ): CodegenClass {
        $class = $cg->codegenClass('Schema')
            ->setIsFinal(true)
            ->setExtendsf('\%s', \Slack\GraphQL\BaseSchema::class)
            ->addConstant(
                $cg->codegenClassConstant('INPUT_TYPES')
                    ->setType('dict<string, classname<Types\NamedInputType>>')
                    ->setValue(self::classnameDict($input_types), HackBuilderValues::literal()),
            )
            ->addConstant(
                $cg->codegenClassConstant('OUTPUT_TYPES')
                    ->setType('dict<string, classname<Types\NamedOutputType>>')
                    ->setValue(self::classnameDict($output_types), HackBuilderValues::literal()),
            );

        $class->addMethod(
            $this->generateSchemaResolveOperationMethod($cg, \Graphpinator\Tokenizer\OperationType::QUERY),
        );

        $query_type = $output_types['Query'];
        $query_type_const = $cg->codegenClassConstant('QUERY_TYPE')
            ->setTypef('classname<\%s>', \Slack\GraphQL\Types\ObjectType::class)
            ->setValue('Query::class', HackBuilderValues::literal());

        $class->addConstant($query_type_const);

        $mutation_type = $output_types['Mutation'] ?? null;
        if ($mutation_type is nonnull) {
            $mutation_type_const = $cg->codegenClassConstant('MUTATION_TYPE')
                ->setTypef('classname<\%s>', \Slack\GraphQL\Types\ObjectType::class)
                ->setValue(('Mutation::class'), HackBuilderValues::literal());

            $class->addConstant($mutation_type_const)
                ->addMethod(
                    $this->generateSchemaResolveOperationMethod($cg, \Graphpinator\Tokenizer\OperationType::MUTATION),
                );
        }

        return $class;
    }

    private static function classnameDict(dict<string, string> $dict): string {
        $lines = vec['dict['];
        foreach (Dict\sort_by_key($dict) as $key => $value) {
            $lines[] = Str\format(
                "  %s => %s::class,",
                \var_export($key, true),
                Str\strip_prefix($value, 'Slack\\GraphQL\\'),
            );
        }
        $lines[] = ']';
        return Str\join($lines, "\n");
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
            ->setReturnType('Awaitable<GraphQL\\ValidFieldResult<?dict<string, mixed>>>')
            ->addParameterf('\%s $operation', \Graphpinator\Parser\Operation\Operation::class)
            ->addParameterf('\%s $variables', \Slack\GraphQL\Variables::class);

        $hb = hb($cg)->addReturnf('await %s->resolveAsync(new GraphQL\\Root(), $operation, $variables)', $root_type);

        $resolve_method->setBody($hb->getCode());

        return $resolve_method;
    }

    private async function collectObjects(): Awaitable<vec<ITypeBuilder>> {
        $objects = vec[];
        $inputs = vec[];
        $query_fields = dict[];
        $mutation_fields = dict[];

        $introspection_parser = await DefinitionFinder\TreeParser::fromPathAsync(__DIR__.'/../Introspection');

        $input_types = Vec\concat($this->parser->getTypes(), $introspection_parser->getTypes());
        foreach ($input_types as $type) {
            $rt = new \ReflectionTypeAlias($type->getName());
            $graphql_input = $rt->getAttributeClass(\Slack\GraphQL\InputObjectType::class);
            if ($graphql_input is nonnull) {
                $inputs[] = new InputObjectBuilder($graphql_input, $rt);
            }

            $graphql_output = $rt->getAttributeClass(\Slack\GraphQL\ObjectType::class);
            if ($graphql_output is nonnull) {
                $objects[] = ObjectBuilder::fromTypeAlias($graphql_output, $rt);
            }
        }

        $classish_objects = $this->parser->getInterfaces()
            |> Vec\concat($$, $this->parser->getClasses())
            |> Vec\concat($$, $introspection_parser->getInterfaces())
            |> Vec\concat($$, $introspection_parser->getClasses());

        $field_resolver = new FieldResolver($classish_objects);
        $class_fields = $field_resolver->resolveFields();

        $hack_class_to_graphql_object = dict[];
        foreach ($classish_objects as $class) {
            if (!C\is_empty($class->getAttributes())) {
                $rc = new \ReflectionClass($class->getName());
                $graphql_attribute = $rc->getAttributeClass(\Slack\GraphQL\ObjectType::class);
                if ($graphql_attribute is nonnull) {
                    $hack_class_to_graphql_object[$rc->getName()] = $graphql_attribute->getType();
                }
            }
        }
        $hack_class_to_graphql_object = Dict\sort_by_key($hack_class_to_graphql_object);

        foreach ($classish_objects as $class) {
            if (!C\is_empty($class->getAttributes())) {
                $rc = new \ReflectionClass($class->getName());
                $fields = $class_fields[$class->getName()];
                $graphql_interface = $rc->getAttributeClass(\Slack\GraphQL\InterfaceType::class);
                $graphql_object = $rc->getAttributeClass(\Slack\GraphQL\ObjectType::class);
                invariant(
                    $graphql_interface is null || $graphql_object is null,
                    'The same class (%s) cannot be both a GraphQL interface and a GraphQL object type.',
                    $rc->getName(),
                );
                if ($graphql_interface is nonnull) {
                    $objects[] = new InterfaceBuilder(
                        $graphql_interface,
                        $rc->getName(),
                        $fields,
                        $hack_class_to_graphql_object,
                    );
                } else if ($graphql_object is nonnull) {
                    $objects[] = new ObjectBuilder($graphql_object, $rc->getName(), $fields);
                }
            }

            foreach ($class->getMethods() as $method) {
                // TODO: right now these need to be static, not sure how we
                // would do it otherwise. Should validate that here.
                if (C\is_empty($method->getAttributes())) continue;

                $method_name = $method->getName();
                $rm = new \ReflectionMethod($class->getName(), $method_name);
                $query_root_field = $rm->getAttributeClass(\Slack\GraphQL\QueryRootField::class);
                if ($query_root_field is nonnull) {
                    $query_fields[$query_root_field->getName()] = new StaticFieldBuilder($query_root_field, $rm);
                    continue;
                }

                // TODO: maybe throw an error if a field is tagged with both query + mutation field?
                $mutation_root_field = $rm->getAttributeClass(\Slack\GraphQL\MutationRootField::class);
                if ($mutation_root_field is nonnull) {
                    $this->has_mutations = true;

                    $mutation_fields[$mutation_root_field->getName()] = new StaticFieldBuilder(
                        $mutation_root_field,
                        $rm,
                    );
                }
            }
        }

        $enums = $this->parser->getEnums() |> Vec\concat($$, $introspection_parser->getEnums());

        foreach ($enums as $enum) {
            $rc = new \ReflectionClass($enum->getName());
            $enum_type = $rc->getAttributeClass(\Slack\GraphQL\EnumType::class);
            if ($enum_type is null) continue;
            $objects[] = new InputEnumBuilder($enum_type, $enum->getName());
            $objects[] = new OutputEnumBuilder($enum_type, $enum->getName());
        }

        // TODO: throw an error if no query fields?

        if (!C\is_empty($query_fields)) {
            $top_level_objects = vec[
                new ObjectBuilder(
                    new \Slack\GraphQL\__Private\CompositeType('Query', 'Query'),
                    'Slack\\GraphQL\\Root',
                    vec(Dict\sort_by_key($query_fields)),
                ),
            ];

            if (!C\is_empty($mutation_fields)) {
                $top_level_objects[] = new ObjectBuilder(
                    new \Slack\GraphQL\__Private\CompositeType('Mutation', 'Mutation'),
                    'Slack\\GraphQL\\Root',
                    vec(Dict\sort_by_key($mutation_fields)),
                );
            }

            $objects = Vec\concat($top_level_objects, $objects, $inputs);
        }

        return Vec\sort_by($objects, $object ==> $object->getGraphQLType());
    }
}
