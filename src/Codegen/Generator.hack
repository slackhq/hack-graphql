namespace Slack\GraphQL\Codegen;

use namespace Slack\GraphQL\Types;
use namespace Facebook\HHAST;
use namespace Facebook\DefinitionFinder;
use namespace HH\Lib\{Str, Vec, C, Dict};
use type Facebook\HackCodegen\{
    CodegenFile,
    CodegenFileType,
    CodegenClass,
    CodegenClassConstant,
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

interface GeneratableClass {
    public function generateClass(HackCodegenFactory $cg): CodegenClass;
    public function getInputTypeName(): ?string;
    public function getOutputTypeName(): ?string;
    protected function generateFieldNamesClassConstant(HackCodegenFactory $cg): ?CodegenClassConstant;
}

abstract class BaseObject<T as Field> implements GeneratableClass {
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

    protected function generateFieldNamesClassConstant(HackCodegenFactory $cg): ?CodegenClassConstant {
        $field_names_constant = $cg->codegenClassConstant('FIELD_NAMES')
            ->setType('keyset<string>')
            ->setValue(
                Vec\map($this->fields, $field ==> $field->getName()) |> keyset($$),
                HackBuilderValues::keyset(HackBuilderValues::export()),
            );

        return $field_names_constant;
    }

    public function getInputTypeName(): null {
        return null;
    }
}


class Query extends BaseObject<QueryField> {
    public function __construct(protected vec<QueryField> $fields) {}

    public function generateClass(HackCodegenFactory $cg): CodegenClass {
        $class = $cg->codegenClass('Query')
            ->setExtendsf('\%s', \Slack\GraphQL\Types\ObjectType::class);

        $hack_type_constant = $cg->codegenClassConstant('THackType')
            ->setType('type')
            ->setValue('GraphQL\\Root', HackBuilderValues::literal());

        $class->addConstant($hack_type_constant);
        $class->addConstant($cg->codegenClassConstant('NAME')->setValue('Query', HackBuilderValues::export()));

        $field_names_const = $this->generateFieldNamesClassConstant($cg);
        if ($field_names_const is nonnull) {
            $class->addConstant($field_names_const);
        }
        $class->addMethod($this->generateGetFieldDefinition($cg));

        return $class;
    }

    public function getOutputTypeName(): string {
        return 'Query';
    }
}

class Mutation extends BaseObject<MutationField> {
    public function __construct(protected vec<MutationField> $fields) {}

    public function generateClass(HackCodegenFactory $cg): CodegenClass {
        $class = $cg->codegenClass('Mutation')
            ->setExtendsf('\%s', \Slack\GraphQL\Types\ObjectType::class);

        $hack_type_constant = $cg->codegenClassConstant('THackType')
            ->setType('type')
            ->setValue('GraphQL\\Root', HackBuilderValues::literal());

        $class->addConstant($hack_type_constant);
        $class->addConstant($cg->codegenClassConstant('NAME')->setValue('Mutation', HackBuilderValues::export()));

        $field_names_const = $this->generateFieldNamesClassConstant($cg);
        if ($field_names_const is nonnull) {
            $class->addConstant($field_names_const);
        }
        $class->addMethod($this->generateGetFieldDefinition($cg));

        return $class;
    }

    public function getOutputTypeName(): string {
        return 'Mutation';
    }
}

abstract class CompositeType<T as \Slack\GraphQL\__Private\CompositeType> extends BaseObject<Field> {
    public function __construct(
        private DefinitionFinder\ScannedClassish $class,
        private T $composite_type,
        private \ReflectionClass $reflection_class,
        protected vec<Field> $fields,
    ) {}

    public function getFields(): vec<Field> {
        return $this->fields;
    }

    public function generateClass(HackCodegenFactory $cg): CodegenClass {
        $class = $cg->codegenClass($this->composite_type->getType())
            ->setExtends($this->getClassExtends());

        $hack_type_constant = $cg->codegenClassConstant('THackType')
            ->setType('type')
            ->setValue('\\'.$this->class->getName(), HackBuilderValues::literal());

        $class->addConstant($hack_type_constant);
        $class->addConstant(
            $cg->codegenClassConstant('NAME')->setValue($this->composite_type->getType(), HackBuilderValues::export()),
        );

        $field_names_const = $this->generateFieldNamesClassConstant($cg);
        if ($field_names_const is nonnull) {
            $class->addConstant($field_names_const);
        }
        $class->addMethod($this->generateGetFieldDefinition($cg));

        return $class;
    }

    public function getOutputTypeName(): string {
        return $this->composite_type->getType();
    }

    abstract protected function getClassExtends(): string;
}

class InterfaceType extends CompositeType<\Slack\GraphQL\InterfaceType> {
    protected function getClassExtends(): string {
        return Str\format('\%s', \Slack\GraphQL\Types\InterfaceType::class);
    }
}

class ObjectType extends CompositeType<\Slack\GraphQL\ObjectType> {
    protected function getClassExtends(): string {
        return Str\format('\%s', \Slack\GraphQL\Types\ObjectType::class);
    }
}

class Field {
    public function __construct(
        protected DefinitionFinder\ScannedClassish $class,
        protected DefinitionFinder\ScannedMethod $method,
        protected \ReflectionMethod $reflection_method,
        protected \Slack\GraphQL\Field $graphql_field,
    ) {}

    final public function getName(): string {
        return $this->graphql_field->getName();
    }

    final public function addGetFieldDefinitionCase(HackBuilder $hb): void {
        $hb->addCase($this->graphql_field->getName(), HackBuilderValues::export());

        $hb->addLine('return new GraphQL\\FieldDefinition(')->indent();
        $hb->addLinef("'%s',", $this->graphql_field->getName());

        // Field return type
        $type_info = output_type(
            $this->reflection_method->getReturnTypeText(),
            $this->reflection_method->getAttributeClass(\Slack\GraphQL\KillsParentOnException::class) is nonnull,
        );
        $hb->addLinef('%s,', $type_info['type']);

        // Arguments
        $hb->addf(
            'async ($schema, $parent, $args, $vars) ==> %s%s%s(',
            $type_info['needs_await'] ? 'await ' : '',
            $this->getMethodCallPrefix(),
            $this->method->getName(),
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

    public function hasArguments(): bool {
        return $this->reflection_method->getNumberOfParameters() > 0;
    }

    protected function getArgumentInvocationStrings(): vec<string> {
        $invocations = vec[];
        foreach ($this->reflection_method->getParameters() as $index => $param) {
            $type_text = $param->getTypeText();
            // TODO: support passing a custom context down in a similar way to this:J
            // if ($type_text === 'HH\classname<Slack\GraphQL\Introspection\IntrospectableSchema>') {
            //     $invocations[] = '$schema';
            //     continue;
            // }

            $invocations[] = Str\format(
                '%s->coerceNode($args[%s]->getValue(), $vars)',
                input_type($type_text),
                \var_export($param->getName(), true),
            );
        }
        return $invocations;
    }
}

class QueryField extends Field {
    <<__Override>>
    protected function getMethodCallPrefix(): string {
        return '\\'.$this->class->getName().'::';
    }
}

class MutationField extends QueryField {}

abstract class BaseEnumType implements GeneratableClass {
    public function __construct(
        protected DefinitionFinder\ScannedEnum $scanned_enum,
        protected \Slack\GraphQL\EnumType $enum_type,
    ) {}

    abstract protected function getGraphQLTypeName(): string;
    abstract const string TYPE_CONSTANT_NAME;
    abstract const classname<\Slack\GraphQL\Types\BaseType> ENUM_TYPE;

    public function generateClass(HackCodegenFactory $cg): CodegenClass {
        return $cg->codegenClass($this->getGraphQLTypeName())
            ->setExtendsf('\%s', $this::ENUM_TYPE)
            ->addConstant(
                $cg->codegenClassConstant('NAME')
                    ->setValue($this->enum_type->getType(), HackBuilderValues::export()),
            )
            ->addTypeConstant(
                $cg->codegenTypeConstant($this::TYPE_CONSTANT_NAME)
                    ->setValue('\\'.$this->scanned_enum->getName(), HackBuilderValues::literal()),
            )
            ->addConstant(
                $cg->codegenClassConstant('HACK_ENUM')
                    ->setTypef('\\HH\\enumname<this::%s>', $this::TYPE_CONSTANT_NAME)
                    ->setValue('\\'.$this->scanned_enum->getName().'::class', HackBuilderValues::literal()),
            );
    }

    protected function generateFieldNamesClassConstant(HackCodegenFactory $cg): ?CodegenClassConstant {
        return null;
    }
}

class EnumInputType extends BaseEnumType {
    const TYPE_CONSTANT_NAME = 'TCoerced';
    const classname<\Slack\GraphQL\Types\EnumInputType> ENUM_TYPE = \Slack\GraphQL\Types\EnumInputType::class;
    protected function getGraphQLTypeName(): string {
        return $this->enum_type->getInputType();
    }
    public function getInputTypeName(): string {
        return $this->enum_type->getType();
    }
    public function getOutputTypeName(): null {
        return null;
    }
}

class EnumOutputType extends BaseEnumType {
    const TYPE_CONSTANT_NAME = 'THackType';
    const classname<\Slack\GraphQL\Types\EnumOutputType> ENUM_TYPE = \Slack\GraphQL\Types\EnumOutputType::class;
    protected function getGraphQLTypeName(): string {
        return $this->enum_type->getOutputType();
    }
    public function getInputTypeName(): null {
        return null;
    }
    public function getOutputTypeName(): string {
        return $this->enum_type->getType();
    }
}

final class Generator {
    private HackCodegenFactory $cg;
    private bool $has_mutations = false;

    const type TGeneratorConfig = shape(
        'output_path' => string,
        ?'codegen_config' => IHackCodegenConfig,
    );

    private function __construct(private DefinitionFinder\BaseParser $parser, private self::TGeneratorConfig $config) {
        $this->cg = new HackCodegenFactory($config['codegen_config'] ?? new HackCodegenConfig());
    }

    public static async function forPath(string $path, self::TGeneratorConfig $config): Awaitable<CodegenFile> {
        $defs = await DefinitionFinder\TreeParser::fromPathAsync($path);
        $gen = new self($defs, $config);
        return await $gen->generate();
    }

    public static async function forFile(string $filename, self::TGeneratorConfig $config): Awaitable<CodegenFile> {
        $defs = await DefinitionFinder\FileParser::fromFileAsync($filename);
        $gen = new self($defs, $config);
        return await $gen->generate();
    }

    public async function generate(): Awaitable<CodegenFile> {
        $objects = await $this->collectObjects();

        $file = $this->cg
            ->codegenFile($this->config['output_path'])
            ->setDoClobber(true)
            ->setGeneratedFrom($this->cg->codegenGeneratedFromScript('vendor/bin/hacktest'))
            ->setFileType(CodegenFileType::DOT_HACK)
            ->useNamespace('Slack\\GraphQL')
            ->useNamespace('Slack\\GraphQL\\Types')
            ->useNamespace('HH\\Lib\\{C, Dict}');

        $input_types = BUILTIN_INPUT_TYPES;
        $output_types = BUILTIN_OUTPUT_TYPES;

        $has_type_assertions = false;
        foreach ($objects as $object) {
            $class = $object->generateClass($this->cg)
                ->setIsFinal(true);
            $file->addClass($class);
            $input_types = self::add($input_types, $object->getInputTypeName(), $class->getName());
            $output_types = self::add($output_types, $object->getOutputTypeName(), $class->getName());
        }

        $file->addClass($this->generateSchemaType($this->cg, $input_types, $output_types, $objects));

        return $file;
    }

    private static function add(dict<string, string> $dict, ?string $key, string $value): dict<string, string> {
        if ($key is null) {
            return $dict;
        }
        invariant(!C\contains_key($dict, $key), 'Conflicting entry for "%s": "%s" vs "%s"', $key, $dict[$key], $value);
        $dict[$key] = $value;
        return $dict;
    }

    private function generateSchemaType(
        HackCodegenFactory $cg,
        dict<string, string> $input_types,
        dict<string, string> $output_types,
        vec<GeneratableClass> $objects,
    ): CodegenClass {
        $class = $cg->codegenClass('Schema')
            ->setIsAbstract(true)
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

        foreach ($objects as $object) {
            if ($object is Query) {
                $query_type_const = $cg->codegenClassConstant('QUERY_TYPE')
                    ->setTypef('classname<\%s>', \Slack\GraphQL\Types\ObjectType::class)
                    ->setValue('Query::class', HackBuilderValues::literal());

                $class->addConstant($query_type_const);
            } else if ($object is Mutation) {
                $mutation_type_const = $cg->codegenClassConstant('MUTATION_TYPE')
                    ->setTypef('classname<\%s>', \Slack\GraphQL\Types\ObjectType::class)
                    ->setValue(('Mutation::class'), HackBuilderValues::literal());

                $class->addConstant($mutation_type_const)
                    ->addMethod(
                        $this->generateSchemaResolveOperationMethod(
                            $cg,
                            \Graphpinator\Tokenizer\OperationType::MUTATION,
                        ),
                    );
            }
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

        $hb = hb($cg)->addReturnf(
            'await %s->resolveAsync(self::class, new GraphQL\\Root(), $operation, $variables)',
            $root_type,
        );

        $resolve_method->setBody($hb->getCode());

        return $resolve_method;
    }

    private async function collectObjects<T as Field>(): Awaitable<vec<GeneratableClass>> {
        $interfaces = dict[];
        $objects = vec[];
        $inputs = vec[];
        $query_fields = vec[];
        $mutation_fields = vec[];

        $introspection_defs = await DefinitionFinder\FileParser::fromFileAsync(__DIR__.'/../Introspection.hack');

        $input_types = $this->parser->getTypes();
        foreach ($input_types as $type) {
            $rt = new \ReflectionTypeAlias($type->getName());
            $graphql_input = $rt->getAttributeClass(\Slack\GraphQL\InputObjectType::class);
            if ($graphql_input is nonnull) {
                $inputs[] = new InputObjectType($rt, $graphql_input);
            }

            $graphql_output = $rt->getAttributeClass(\Slack\GraphQL\ObjectType::class);
            if ($graphql_output is nonnull) {
                $objects[] = new OutputObjectType($rt, $graphql_output);
            }
        }

        $classish_objects = $this->parser->getInterfaces()
            |> Vec\concat($$, $this->parser->getClasses())
            |> Vec\concat($$, $introspection_defs->getClasses());

        $field_resolver = new FieldResolver($classish_objects);
        $class_fields = $field_resolver->resolveFields();

        foreach ($classish_objects as $class) {
            if (!C\is_empty($class->getAttributes())) {
                $rc = new \ReflectionClass($class->getName());
                $fields = $class_fields[$class->getName()];
                $graphql_attribute = $rc->getAttributeClass(\Slack\GraphQL\InterfaceType::class) ??
                    $rc->getAttributeClass(\Slack\GraphQL\ObjectType::class);
                if ($graphql_attribute is \Slack\GraphQL\InterfaceType) {
                    $objects[] = new InterfaceType($class, $graphql_attribute, $rc, $fields);
                } elseif ($graphql_attribute is \Slack\GraphQL\ObjectType) {
                    $objects[] = new ObjectType($class, $graphql_attribute, $rc, $fields);
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
                    $query_fields[] = new QueryField($class, $method, $rm, $query_root_field);
                    continue;
                }

                // TODO: maybe throw an error if a field is tagged with both query + mutation field?
                $mutation_root_field = $rm->getAttributeClass(\Slack\GraphQL\MutationRootField::class);
                if ($mutation_root_field is nonnull) {
                    $mutation_fields[] = new MutationField($class, $method, $rm, $mutation_root_field);
                }
            }
        }

        foreach (Vec\concat($this->parser->getEnums(), $introspection_defs->getEnums()) as $enum) {
            $rc = new \ReflectionClass($enum->getName());
            $enum_type = $rc->getAttributeClass(\Slack\GraphQL\EnumType::class);
            if ($enum_type is null) continue;
            $objects[] = new EnumInputType($enum, $enum_type);
            $objects[] = new EnumOutputType($enum, $enum_type);
        }

        // TODO: throw an error if no query fields?

        if (!C\is_empty($query_fields)) {
            $top_level_objects = vec[new Query($query_fields)];

            if (!C\is_empty($mutation_fields)) {
                $top_level_objects[] = new Mutation($mutation_fields);
            }

            $objects = Vec\concat($top_level_objects, $objects, $inputs);
        }

        return $objects;
    }
}
