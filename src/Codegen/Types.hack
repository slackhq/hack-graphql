


namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{C, Dict, Str};
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
    $class = get_graphql_leaf_type($unwrapped) ?? get_input_object_type($unwrapped);
    if ($class is null) {
        throw new \Error(
            'GraphQL\Field argument types must be scalar or be enums/input objects annnotated with a GraphQL '.
            'attribute, got '.
            $unwrapped,
        );
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
        $hack_type = unwrap_awaitable($hack_type);
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

    $class = get_output_type($unwrapped);
    if ($class is null) {
        throw new \Error('GraphQL\Field return types must be scalar or be classes annnotated with a GraphQL attribute');
    } elseif (Str\starts_with($class, 'Slack\\GraphQL\\')) {
        $class = Str\strip_prefix($class, 'Slack\\GraphQL\\');
    } else {
        // Class is user-defined, strip off the namespace since the generated
        // GQL type isn't namespaced
        $class = Str\split($class, '\\') |> C\lastx($$);
    }
    return shape('type' => $class.$suffix, 'needs_await' => $needs_await);
}

/**
 * Get the input class for a hack type which is not a primitive.
 */
function get_input_object_type(string $hack_type): ?string {
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

function get_graphql_leaf_type(string $hack_type): ?string {
    switch ($hack_type) {
        case 'HH\int':
            return Types\IntType::class;
        case 'HH\string':
            return Types\StringType::class;
        case 'HH\bool':
            return Types\BooleanType::class;
        default:
            try {
                $rc = new \ReflectionClass($hack_type);
                $graphql_enum = $rc->getAttributeClass(\Slack\GraphQL\EnumType::class);
                if ($graphql_enum is nonnull) {
                    return $graphql_enum->getType();
                }
            } catch (\ReflectionException $_e) {
            }
            return null;
    }
}

/**
 * Get the GraphQL type to output for a hack type.
 */
function get_output_type(string $hack_type): ?string {
    return get_graphql_leaf_type($hack_type) ?? get_output_class($hack_type);
}

/**
 * Get the output class for a hack type which is not a primitive.
 */
function get_output_class(string $hack_type): ?string {
    try {
        $rc = new \ReflectionClass($hack_type);

        $graphql_object = $rc->getAttributeClass(\Slack\GraphQL\ObjectType::class);
        if ($graphql_object) {
            return $graphql_object->getType();
        } elseif (is_connection_type($rc)) {
            return $rc->getName();
        }

        $graphql_interface = $rc->getAttributeClass(\Slack\GraphQL\InterfaceType::class);
        if ($graphql_interface) {
            return $graphql_interface->getType();
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

/**
 * Retrieve the inner type from an awaitable.
 */
function unwrap_awaitable(string $name): string {
    if (!Str\starts_with($name, 'HH\Awaitable')) {
        return $name;
    }
    return Str\strip_prefix($name, 'HH\\Awaitable<') |> Str\strip_suffix($$, '>');
}

enum IO: string as string {
    INPUT = 'Input';
    OUTPUT = 'Output';
}

/**
 * Get the type aias for the given type structure.
 */
function type_structure_to_type_alias<T>(TypeStructure<T> $ts): string {
    $prefix = ($ts['nullable'] ?? false) ? '?' : '';

    $alias = Shapes::idx($ts, 'alias');
    if ($alias is nonnull) {
        return $prefix.$alias;
    }

    switch ($ts['kind']) {
        case TypeStructureKind::OF_INT:
            return $prefix.'HH\int';
        case TypeStructureKind::OF_STRING:
            return $prefix.'HH\string';
        case TypeStructureKind::OF_BOOL:
            return $prefix.'HH\bool';
        case TypeStructureKind::OF_VEC:
            return $prefix.Str\format('HH\vec<%s>', type_structure_to_type_alias($ts['generic_types'] as nonnull[0]));
        case TypeStructureKind::OF_ENUM:
        case TypeStructureKind::OF_INTERFACE:
            //case TypeStructureKind::OF_UNRESOLVED: // not sure if this is needed
            return $prefix.$ts['classname'] as nonnull;
        default:
            invariant_violation(
                'Shape fields %s cannot be used as object fields.',
                TypeStructureKind::getNames()[$ts['kind']],
            );
    }
}

/**
 * Whether the class implements a GraphQL connection.
 */
function is_connection_type(\ReflectionClass $rc): bool {
    if (!Str\ends_with($rc->getName(), 'Connection')) {
        return false;
    }
    return \is_subclass_of($rc->getName(), \Slack\GraphQL\Pagination\Connection::class);
}

/**
 * Whether this method returns a GraphQL connection.
 */
function returns_connection_type(\ReflectionMethod $rm): bool {
    try {
        $rc = new \ReflectionClass(unwrap_awaitable($rm->getReturnTypeText()));
        return is_connection_type($rc);
    } catch (\ReflectionException $_) {
        return false;
    }
}

/**
 * Get the hack type, gql type, and output type for a connection node.
 */
function get_node_type_info(string $hack_type): ?shape(
    'hack_type' => string,
    'gql_type' => string,
    'output_type' => string,
) {
    $output_type = get_output_type($hack_type);
    if ($output_type is null) {
        return null;
    }
    if (Str\starts_with($hack_type, 'HH\\')) {
        // Primitive type, no need to escape namespace
        $hack_type = Str\strip_prefix($hack_type, 'HH\\');
        // Strip off the root namespace as we'll be using `Types\` already.
        $output_type = Str\strip_prefix($output_type, 'Slack\\GraphQL\\');
        // Strip off the `Types` namespace as this will become the name of the class and file.
        $gql_type = Str\strip_prefix($output_type, 'Types\\');
    } else {
        $hack_type = '\\'.$hack_type;
        $gql_type = $output_type;
    }
    return shape(
        'hack_type' => $hack_type,
        'gql_type' => $gql_type,
        'output_type' => $output_type,
    );
}

function get_interfaces(
    string $hack_type,
    dict<string, string> $hack_class_to_graphql_interface,
): dict<string, string> {
    return Dict\filter_with_key(
        $hack_class_to_graphql_interface,
        ($interface, $_gql_type) ==> \is_subclass_of($hack_type, $interface),
    );
}
