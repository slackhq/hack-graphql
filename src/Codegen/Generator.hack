


namespace Slack\GraphQL\Codegen;

use namespace Slack\GraphQL\Types;
use namespace Facebook\DefinitionFinder;
use namespace HH\Lib\{Str, Vec, C, Dict, Keyset};
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

    private function __construct(private MultiParser $parser, private self::TGeneratorConfig $config) {
        $this->cg = new HackCodegenFactory($config['codegen_config'] ?? new HackCodegenConfig());
    }

    private static async function init(
        DefinitionFinder\BaseParser $parser,
        self::TGeneratorConfig $config,
    ): Awaitable<Generator> {
        $parsers = vec[$parser];
        $parsers[] = await DefinitionFinder\TreeParser::fromPathAsync(__DIR__.'/../Introspection');
        $parsers[] = await DefinitionFinder\FileParser::fromFileAsync(__DIR__.'/../Pagination/PageInfo.hack');
        return new Generator(new MultiParser($parsers), $config);
    }

    public static async function forPath(string $path, self::TGeneratorConfig $config): Awaitable<void> {
        $defs = await DefinitionFinder\TreeParser::fromPathAsync($path);
        $gen = await Generator::init($defs, $config);
        await $gen->generate();
    }

    public static async function forFile(string $filename, self::TGeneratorConfig $config): Awaitable<void> {
        $defs = await DefinitionFinder\FileParser::fromFileAsync($filename);
        $gen = await Generator::init($defs, $config);
        await $gen->generate();
    }

    public async function generate(): Awaitable<void> {
        $objects = await $this->collectObjects();

        self::removeDirectory($this->config['output_directory']);
        \mkdir($this->config['output_directory']);

        $types = BUILTIN_TYPES;

        foreach ($objects as $object) {
            $class = $object->build($this->cg);
            $this->generateFile($class);
            if ($object is TypeBuilder<_>) {
                $types = self::add($types, $object->getGraphQLType(), $class->getName());
            }
        }

        $this->generateFile($this->generateSchemaType($this->cg, $types));
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

    private function generateSchemaType(HackCodegenFactory $cg, dict<string, string> $types): CodegenClass {
        $class = $cg->codegenClass('Schema')
            ->setIsFinal(true)
            ->setExtendsf('\%s', \Slack\GraphQL\BaseSchema::class)
            ->addConstant(
                $cg->codegenClassConstant('TYPES')
                    ->setType('dict<string, classname<Types\NamedType>>')
                    ->setValue(self::classnameDict($types), HackBuilderValues::literal()),
            );

        $class->addMethod(
            $this->generateSchemaResolveOperationMethod($cg, \Graphpinator\Tokenizer\OperationType::QUERY),
        );

        $query_type = $types['Query'];
        $query_type_const = $cg->codegenClassConstant('QUERY_TYPE')
            ->setTypef('classname<\%s>', \Slack\GraphQL\Types\ObjectType::class)
            ->setValue('Query::class', HackBuilderValues::literal());

        $class->addConstant($query_type_const);

        $mutation_type = $types['Mutation'] ?? null;
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
                $root_type = 'Query::nullableOutput()';
                break;
            case \Graphpinator\Tokenizer\OperationType::MUTATION:
                $method_name = 'resolveMutation';
                $root_type = 'Mutation::nullableOutput()';
                break;
            case \Graphpinator\Tokenizer\OperationType::SUBSCRIPTION:
                invariant(false, 'TODO: support subscription');
        }

        $resolve_method = $cg->codegenMethod($method_name)
            ->setPublic()
            ->setIsAsync(true)
            ->setReturnType('Awaitable<GraphQL\\ValidFieldResult<?dict<string, mixed>>>')
            ->addParameterf('\%s $operation', \Graphpinator\Parser\Operation\Operation::class)
            ->addParameterf('\%s $context', \Slack\GraphQL\ExecutionContext::class);

        $hb = hb($cg)->addReturnf('await %s->resolveAsync(new GraphQL\\Root(), vec[$operation], $context)', $root_type);

        $resolve_method->setBody($hb->getCode());

        return $resolve_method;
    }

    private async function collectObjects(): Awaitable<vec<ITypeBuilder>> {
        $objects = vec[];
        $query_fields = dict[
            '__schema' => FieldBuilder::introspectSchemaField(),
            '__type' => FieldBuilder::introspectTypeField(),
        ];
        $mutation_fields = dict[];

        $classish_objects = $this->parser->getClassishObjects();

        $field_resolver = new FieldResolver($classish_objects);
        $class_fields = $field_resolver->resolveFields();

        $hack_class_to_graphql_interface = dict[];
        $hack_class_to_graphql_object = dict[];
        foreach ($classish_objects as $class) {
            if (!C\is_empty($class->getAttributes())) {
                $rc = new \ReflectionClass($class->getName());
                $graphql_object = $rc->getAttributeClass(\Slack\GraphQL\ObjectType::class);
                if ($graphql_object is nonnull) {
                    $hack_class_to_graphql_object[$rc->getName()] = $graphql_object->getType();
                }

                $graphql_interface = $rc->getAttributeClass(\Slack\GraphQL\InterfaceType::class);
                if ($graphql_interface is nonnull) {
                    $hack_class_to_graphql_interface[$rc->getName()] = $graphql_interface->getType();
                }
            }
        }
        $hack_class_to_graphql_object = Dict\sort_by_key($hack_class_to_graphql_object);
        $hack_class_to_graphql_interface = Dict\sort_by_key($hack_class_to_graphql_interface);

        $input_types = $this->parser->getTypes();
        foreach ($input_types as $type) {
            $rt = new \ReflectionTypeAlias($type->getName());
            $graphql_input = $rt->getAttributeClass(\Slack\GraphQL\InputObjectType::class);
            if ($graphql_input is nonnull) {
                $objects[] = new InputObjectBuilder($graphql_input, $rt);
            }

            $graphql_output = $rt->getAttributeClass(\Slack\GraphQL\ObjectType::class);
            if ($graphql_output is nonnull) {
                $objects[] = ObjectBuilder::fromTypeAlias($graphql_output, $rt);
            }
        }

        foreach ($classish_objects as $class) {
            $rc = new \ReflectionClass($class->getName());
            if (
                \is_subclass_of($class->getName(), \Slack\GraphQL\Pagination\Connection::class) &&
                $rc->getAttributeClass(\Slack\GraphQL\ObjectType::class)
            ) {
                invariant(
                    Str\ends_with($class->getName(), 'Connection'),
                    "All connection types must have names ending with `Connection`. `%s` does not.",
                    $class->getName(),
                );
                $objects = Vec\concat($objects, $this->getConnectionObjects($class, $class_fields[$class->getName()]));
            } elseif (C\contains_key($class_fields, $class->getName())) {
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
                    $objects[] = new ObjectBuilder(
                        $graphql_object,
                        $rc->getName(),
                        $fields,
                        $hack_class_to_graphql_interface,
                    );
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
                    $query_fields[$query_root_field->getName()] = FieldBuilder::forRootField($query_root_field, $rm);
                    continue;
                }

                // TODO: maybe throw an error if a field is tagged with both query + mutation field?
                $mutation_root_field = $rm->getAttributeClass(\Slack\GraphQL\MutationRootField::class);
                if ($mutation_root_field is nonnull) {
                    $this->has_mutations = true;

                    $mutation_fields[$mutation_root_field->getName()] = FieldBuilder::forRootField(
                        $mutation_root_field,
                        $rm,
                    );
                }
            }
        }

        $enums = $this->parser->getEnums();
        foreach ($enums as $enum) {
            $rc = new \ReflectionClass($enum->getName());
            $enum_type = $rc->getAttributeClass(\Slack\GraphQL\EnumType::class);
            if ($enum_type is null) continue;
            $objects[] = new EnumBuilder($enum_type, $enum->getName());
        }

        $objects[] = new ObjectBuilder(
            new \Slack\GraphQL\ObjectType('Query', 'Query'),
            'Slack\\GraphQL\\Root',
            vec(Dict\sort_by_key($query_fields)),
            $hack_class_to_graphql_interface,
        );

        if (!C\is_empty($mutation_fields)) {
            $objects[] = new ObjectBuilder(
                new \Slack\GraphQL\ObjectType('Mutation', 'Mutation'),
                'Slack\\GraphQL\\Root',
                vec(Dict\sort_by_key($mutation_fields)),
                $hack_class_to_graphql_interface,
            );
        }

        return Vec\sort_by($objects, $object ==> $object->getGraphQLType());
    }

    private function getConnectionObjects(
        DefinitionFinder\ScannedClassish $class,
        vec<FieldBuilder> $additional_fields,
    ): vec<ObjectBuilder> {
        $rc = new \ReflectionClass($class->getName());
        $hack_type = $rc->getTypeConstants()
            |> C\find($$, $c ==> $c->getName() === 'TNode')?->getAssignedTypeText();
        invariant($hack_type is nonnull, '"%s" must declare a type constant "TNode"', $rc->getName());
        $type_info = get_node_type_info($hack_type);
        invariant(
            $type_info is nonnull,
            'Node type "%s" for "%s" must be a valid GraphQL output type. It may not be a list.',
            $hack_type,
            $rc->getName(),
        );
        return vec[
            ObjectBuilder::forConnection($class->getName(), $type_info['gql_type'].'Edge', $additional_fields),
            ObjectBuilder::forEdge($type_info['gql_type'], $type_info['hack_type'], $type_info['output_type']),
        ];
    }
}
