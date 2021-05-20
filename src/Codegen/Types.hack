namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\Str;
use namespace Slack\GraphQL\Types;

const dict<string, classname<Types\LeafType>> BUILTIN_TYPES = dict[
    Types\IntType::NAME => Types\IntType::class,
    Types\StringType::NAME => Types\StringType::class,
    Types\BooleanType::NAME => Types\BooleanType::class,
];

/**
 * Examples:
 *   int       -> IntInputType::nonNullable()
 *   ?int      -> IntInputType::nullable()
 *   ?vec<int> -> IntInputType::nonNullable()->nullableListOf()
 */
function input_type(string $hack_type): string {
    list($unwrapped, $suffix) = unwrap_type(IO::INPUT, $hack_type);
    switch ($unwrapped) {
        case 'HH\int':
            $class = Types\IntType::class;
            break;
        case 'HH\string':
            $class = Types\StringType::class;
            break;
        case 'HH\bool':
            $class = Types\BooleanType::class;
            break;
        default:
            $class = get_input_class($unwrapped);
            if ($class is null) {
                throw new \Error(
                    'GraphQL\Field argument types must be scalar or be enums/input objects annnotated with a GraphQL '.
                    'attribute, got '.$unwrapped,
                );
            }
    }
    return Str\strip_prefix($class, 'Slack\\GraphQL\\').$suffix;
}

/**
 * Same but for output types. By default, we ignore the nullability of the Hack type and force all GraphQL field return
 * types to be nullable, so that we can return `null` as the field value in the GraphQL response in case of exceptions.
 * TODO: Add a way to override this.
 */
function output_type(
    string $hack_type,
    bool $kills_parent_on_exception,
): shape('type' => string, 'needs_await' => bool) {
    $needs_await = false;
    if (Str\starts_with($hack_type, 'HH\\Awaitable<')) {
        $needs_await = true;
        $hack_type = Str\strip_prefix($hack_type, 'HH\\Awaitable<') |> Str\strip_suffix($$, '>');
    }

    if ($kills_parent_on_exception) {
        invariant(
            !Str\starts_with($hack_type, '?'),
            '<<%s>> cannot be used on methods with a nullable return type.',
            \Slack\GraphQL\KillsParentOnException::class,
        );
    } else if (!Str\starts_with($hack_type, '?')) {
        $hack_type = '?'.$hack_type;
    }

    list($unwrapped, $suffix) = unwrap_type(IO::OUTPUT, $hack_type);

    switch ($unwrapped) {
        case 'HH\int':
            $class = Types\IntType::class;
            break;
        case 'HH\string':
            $class = Types\StringType::class;
            break;
        case 'HH\bool':
            $class = Types\BooleanType::class;
            break;
        default:
            $class = get_output_class($unwrapped);
            if ($class is null) {
                throw new \Error(
                    'GraphQL\Field return types must be scalar or be classes annnotated with a GraphQL attribute',
                );
            }
    }
    return shape('type' => Str\strip_prefix($class, 'Slack\\GraphQL\\').$suffix, 'needs_await' => $needs_await);
}

/**
 * Get the input class for a hack type which is not a primitive.
 */
function get_input_class(string $hack_type): ?string {
    try {
        $rc = new \ReflectionClass($hack_type);
        $graphql_enum = $rc->getAttributeClass(\Slack\GraphQL\EnumType::class);
        if ($graphql_enum is nonnull) {
            return $graphql_enum->getType();
        }
    } catch (\ReflectionException $_e) {
    }

    try {
        $rt = new \ReflectionTypeAlias($hack_type);
        $graphql_input = $rt->getAttributeClass(\Slack\GraphQL\InputObjectType::class);
        if ($graphql_input is nonnull) {
            return $graphql_input->getType();
        }
    } catch (\ReflectionException $_e) {
    }

    return null;
}

/**
 * Get the output class for a hack type which is not a primitive.
 */
function get_output_class(string $hack_type): ?string {
    try {
        $rc = new \ReflectionClass($hack_type);

        $graphql_object = $rc->getAttributeClass(\Slack\GraphQL\ObjectType::class) ??
            $rc->getAttributeClass(\Slack\GraphQL\InterfaceType::class);
        if ($graphql_object) {
            return $graphql_object->getType();
        }

        $graphql_enum = $rc->getAttributeClass(\Slack\GraphQL\EnumType::class);
        if ($graphql_enum) {
            return $graphql_enum->getType();
        }
    } catch (\ReflectionException $_e) {
    }

    try {
        $rt = new \ReflectionTypeAlias($hack_type);
        $graphql_output = $rt->getAttributeClass(\Slack\GraphQL\ObjectType::class);
        if ($graphql_output is nonnull) {
            return $graphql_output->getType();
        }
    } catch (\ReflectionException $_e) {
    }

    return null;
}

/**
 * Shared logic for the above.
 */
function unwrap_type(IO $io, string $hack_type, bool $nullable = false): (string, string) {
    if (Str\starts_with($hack_type, '?')) {
        return unwrap_type($io, Str\strip_prefix($hack_type, '?'), true);
    }
    if (Str\starts_with($hack_type, 'HH\vec<')) {
        list($unwrapped, $suffix) = unwrap_type(
            $io,
            Str\strip_prefix($hack_type, 'HH\vec<') |> Str\strip_suffix($$, '>'),
        );
        return tuple($unwrapped, $suffix.($nullable ? '->nullable'.$io.'ListOf()' : '->nonNullable'.$io.'ListOf()'));
    }
    return tuple($hack_type, $nullable ? '::nullable'.$io.'()' : '::nonNullable()');
}

enum IO: string as string {
    INPUT = 'Input';
    OUTPUT = 'Output';
}

/**
 * Get the type aias for the given type structure.
 */
function type_structure_to_type_alias<T>(TypeStructure<T> $ts): string {
    $alias = Shapes::idx($ts, 'alias');
    if ($alias is nonnull) {
        return $alias;
    }

    switch ($ts['kind']) {
        case TypeStructureKind::OF_INT:
            return 'HH\int';
        case TypeStructureKind::OF_STRING:
            return 'HH\string';
        case TypeStructureKind::OF_BOOL:
            return 'HH\bool';
        case TypeStructureKind::OF_VEC:
            return Str\format('HH\vec<%s>', type_structure_to_type_alias($ts['generic_types'] as nonnull[0]));
        case TypeStructureKind::OF_ENUM:
        //case TypeStructureKind::OF_UNRESOLVED: // not sure if this is needed
            return $ts['classname'] as nonnull;
        default:
            invariant_violation(
                'Shape fields %s cannot be used as object fields.',
                TypeStructureKind::getNames()[$ts['kind']],
            );
    }
}
