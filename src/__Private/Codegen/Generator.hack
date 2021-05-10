namespace Slack\GraphQL\__Private\Codegen;

use namespace Slack\GraphQL\__Private\Types;
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

    abstract public function generateObjectType(HackCodegenFactory $cg): CodegenClass;
    abstract protected function getResolveFieldResolvedParentParameter(): string;

    protected function generateResolveField(HackCodegenFactory $cg): CodegenMethod {
        $method = $cg->codegenMethod('resolveField')
            ->setIsAsync(true)
            ->setIsStatic(true)
            ->setPublic()
            ->setReturnType('Awaitable<mixed>')
            ->addParameter('string $field_name')
            ->addParameter($this->getResolveFieldResolvedParentParameter())
            ->addParameter($this->getResolveFieldArgumentsParameter())
            ->addParameter($this->getResolveFieldVariablesParameter());

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

    private function getResolveFieldArgumentsParameter(): string {
        $var_name = C\any($this->fields, $field ==> $field->hasArguments()) ? '$args' : '$_args';
        return Str\format('dict<string, \Graphpinator\Parser\Value\ArgumentValue> %s', $var_name);
    }

    private function getResolveFieldVariablesParameter(): string {
        $var_name = C\any($this->fields, $field ==> $field->hasArguments()) ? '$vars' : '$_vars';
        return Str\format('\Slack\GraphQL\__Private\Variables %s', $var_name);
    }

    protected function generateResolveType(HackCodegenFactory $cg): CodegenMethod {
        $method = $cg->codegenMethod('resolveType')
            ->setIsStatic(true)
            ->setPublic()
            ->setReturnTypef('\%s', \Slack\GraphQL\__Private\Types\BaseType::class)
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

class Query extends BaseObject<QueryField> {
    public function __construct(protected vec<QueryField> $fields) {}

    public function generateObjectType(HackCodegenFactory $cg): CodegenClass {
        $class = $cg->codegenClass('Query');

        $hack_type_constant =
            $cg->codegenClassConstant('THackType')->setType('type')->setValue(null, HackBuilderValues::export());

        $class->addConstant($hack_type_constant);
        $class->addConstant($cg->codegenClassConstant('NAME')->setValue('Query', HackBuilderValues::export()));

        $class
            ->addMethod($this->generateResolveField($cg))
            ->addMethod($this->generateResolveType($cg));

        return $class;
    }

    protected function getResolveFieldResolvedParentParameter(): string {
        return 'self::THackType $_';
    }
}

class Object extends BaseObject<Field> {
    public function __construct(
        private HHAST\ClassishDeclaration $class_decl,
        private \Slack\GraphQL\Object $graphql_object,
        private \ReflectionClass $reflection_class,
        protected vec<Field> $fields,
    ) {}

    public function generateObjectType(HackCodegenFactory $cg): CodegenClass {
        $class = $cg->codegenClass($this->graphql_object->getType());

        $hack_type_constant = $cg->codegenClassConstant('THackType')
            ->setType('type')
            ->setValue('\\'.$this->class_decl->getName()->getText(), HackBuilderValues::literal());

        $class->addConstant($hack_type_constant);
        $class->addConstant(
            $cg->codegenClassConstant('NAME')->setValue($this->graphql_object->getType(), HackBuilderValues::export())
        );

        $class
            ->addMethod($this->generateResolveField($cg))
            ->addMethod($this->generateResolveType($cg));

        return $class;
    }

    protected function getResolveFieldResolvedParentParameter(): string {
        return 'self::THackType $resolved_parent';
    }
}

class Field {
    public function __construct(
        protected HHAST\ClassishDeclaration $class_decl,
        protected HHAST\MethodishDeclaration $method_decl,
        protected \ReflectionMethod $reflection_method,
        protected \Slack\GraphQL\Field $graphql_field,
    ) {}

    public function addResolveFieldCase(HackBuilder $hb): void {
        $hb->addCase($this->graphql_field->getName(), HackBuilderValues::export());

        $return_prefix = '';
        if ($this->reflection_method->getReturnTypeText() |> Str\starts_with($$, 'HH\Awaitable')) {
            $return_prefix = 'await ';
        }

        $hb->returnCasef(
            '%s$resolved_parent->%s(%s)',
            $return_prefix,
            $this->method_decl->getFunctionDeclHeader()->getName()->getText(),
            $this->getArgumentInvocationString(),
        );
    }

    public function addResolveTypeCase(HackBuilder $hb): void {
        $graphql_type = $this->getGraphQLType();
        $hb
            ->addCase($this->graphql_field->getName(), HackBuilderValues::export())
            ->returnCasef('%s::nullable()', $graphql_type);
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
                return \Slack\GraphQL\__Private\Types\StringOutputType::class
                    |> Str\format('\%s', $$);
            case 'int':
                return \Slack\GraphQL\__Private\Types\IntOutputType::class
                    |> Str\format('\%s', $$);
            case 'bool':
                return \Slack\GraphQL\__Private\Types\BooleanOutputType::class
                    |> Str\format('\%s', $$);
            default:
                // TODO: this doesn't handle custom types, how do we make this
                // better?
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

    public function hasArguments(): bool {
        return $this->reflection_method->getNumberOfParameters() > 0;
    }

    protected function getArgumentInvocationString(): string {
        $invocations = vec[];
        foreach ($this->reflection_method->getParameters() as $index => $param) {
            $invocations[] = Str\format(
                '%s->coerceNode($args[%s]->getValue(), $vars)',
                self::hackTypeToInputTypeFactoryCall($param->getTypeText()),
                \var_export($param->getName(), true),
            );
        }

        return Str\join($invocations, ', ');
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
                $class = \Slack\GraphQL\__Private\Types\IntInputType::class;
                break;
            case 'HH\string':
                $class = \Slack\GraphQL\__Private\Types\StringInputType::class;
                break;
            case 'HH\bool':
                $class = \Slack\GraphQL\__Private\Types\BooleanInputType::class;
                break;
            default:
                invariant_violation('not yet implemented');
        }
        return
            Str\strip_prefix($class, 'Slack\\GraphQL\\__Private\\').
            ($nullable ? '::nullable()' : '::nonNullable()');
    }
}

class QueryField extends Field {

    public function addResolveFieldCase(HackBuilder $hb): void {
        $hb->addCase($this->graphql_field->getName(), HackBuilderValues::export());

        $class_name = $this->class_decl->getName()->getText();

        $return_prefix = '';
        if ($this->reflection_method->getReturnTypeText() |> Str\starts_with($$, 'HH\Awaitable')) {
            $return_prefix = 'await ';
        }

        $hb->returnCasef(
            '%s\%s::%s(%s)',
            $return_prefix,
            $class_name,
            $this->method_decl->getFunctionDeclHeader()->getName()->getText(),
            $this->getArgumentInvocationString(),
        );
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
            ->useNamespace('Slack\\GraphQL\\__Private\\Types')
            ->useNamespace('HH\\Lib\\Dict')
            ->addClass($this->generateSchemaType($this->cg));

        foreach ($objects as $object) {
            $class = $object->generateObjectType($this->cg)
                ->setIsFinal(true)
                ->setExtendsf('\%s', \Slack\GraphQL\__Private\Types\ObjectType::class);
            $file->addClass($class);
        }

        return $file;
    }

    private function generateSchemaType(HackCodegenFactory $cg): CodegenClass {
        $class = $cg->codegenClass('Schema')
            ->setIsAbstract(true)
            ->setIsFinal(true)
            ->setExtendsf('\%s', \Slack\GraphQL\__Private\BaseSchema::class);

        $resolve_query_method = $cg->codegenMethod('resolveQuery')
            ->setPublic()
            ->setIsStatic(true)
            ->setIsAsync(true)
            ->setReturnType('Awaitable<mixed>')
            ->addParameterf('\%s $operation', \Graphpinator\Parser\Operation\Operation::class)
            ->addParameterf('\%s $variables', \Slack\GraphQL\__Private\Variables::class);

        $hb = hb($cg)
            ->addAssignment('$query', 'Query::nullable()', HackBuilderValues::literal())
            ->ensureEmptyLine()
            ->addAssignment('$data', 'dict[]', HackBuilderValues::literal())
            ->startForeachLoop('$operation->getFields()->getFields()', null, '$field') // TODO: ->getFragments()
            ->addLine('$data[$field->getName()] = self::resolveField($field, $query, null, $variables);')
            ->endForeachLoop()
            ->ensureEmptyLine()
            ->addReturn('await Dict\from_async($data)', HackBuilderValues::literal());

        $resolve_query_method->setBody($hb->getCode());

        $class->addMethod($resolve_query_method);

        return $class;
    }

    private async function collectObjects<T as Field>(string $from_path): Awaitable<vec<GeneratableObjectType>> {
        $script = await HHAST\from_file_async(HHAST\File::fromPath($from_path));

        $objects = vec[];
        $query_fields = vec[];
        foreach ($script->getDescendantsOfType(HHAST\ClassishDeclaration::class) as $class_decl) {
            if ($class_decl->hasAttribute()) {
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

            foreach ($class_decl->getDescendantsOfType(HHAST\MethodishDeclaration::class) as $method_decl) {
                // TODO: right now these need to be static, not sure how we
                // would do it otherwise. Should validate that here.
                if (!$method_decl->hasAttribute()) continue;

                $method_name = $method_decl->getFunctionDeclHeader()->getName()->getText();
                $rm = new \ReflectionMethod($class_decl->getName()->getText(), $method_name);
                $query_root_field = $rm->getAttributeClass(\Slack\GraphQL\QueryRootField::class);
                if ($query_root_field is null) continue;

                $query_fields[] = new QueryField($class_decl, $method_decl, $rm, $query_root_field);
            }
        }

        if (!C\is_empty($query_fields)) {
            $objects = Vec\concat(vec[new Query($query_fields)], $objects);
        }

        return $objects;
    }
}
