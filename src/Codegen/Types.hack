namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\Str;
use namespace Slack\GraphQL\Types;

/**
 * Examples:
 *   int       -> IntInputType::nonNullable()
 *   ?int      -> IntInputType::nullable()
 *   ?vec<int> -> IntInputType::nonNullable()->nullableListOf()
 */
function input_type(string $hack_type): string {
    list($unwrapped, $suffix) = unwrap_type($hack_type);
    switch ($unwrapped) {
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
    return Str\strip_prefix($class, 'Slack\\GraphQL\\').$suffix;
}

/**
 * Same but for output types. By default, we ignore the nullability of the Hack type and force all GraphQL field return
 * types to be nullable, so that we can return `null` as the field value in the GraphQL response in case of exceptions.
 * TODO: Add a way to override this.
 */
function output_type(string $hack_type, bool $force_nullable = true): shape('type' => string, 'needs_await' => bool) {
    $needs_await = false;
    if (Str\starts_with($hack_type, 'HH\\Awaitable<')) {
        $needs_await = true;
        $hack_type = Str\strip_prefix($hack_type, 'HH\\Awaitable<') |> Str\strip_suffix($$, '>');
    }

    if ($force_nullable && !Str\starts_with($hack_type, '?')) {
        $hack_type = '?'.$hack_type;
    }

    list($unwrapped, $suffix) = unwrap_type($hack_type);

    switch ($unwrapped) {
        case 'HH\int':
            $class = Types\IntOutputType::class;
            break;
        case 'HH\string':
            $class = Types\StringOutputType::class;
            break;
        case 'HH\bool':
            $class = Types\BooleanOutputType::class;
            break;
        default:
            $class = get_output_class($unwrapped);
            if ($class is null) {
                throw new \Error(
                    'GraphQL\Field return types must be scalar or be classes annnotated with a GraphQL attribute'
                );
            }
    }
    return shape('type' => Str\strip_prefix($class, 'Slack\\GraphQL\\').$suffix, 'needs_await' => $needs_await);
}

/**
 * Get the output class for a hack type which is not a primitive.
 */
function get_output_class(string $hack_type): ?string {
    $rc = new \ReflectionClass($hack_type);

    $graphql_object = $rc->getAttributeClass(\Slack\GraphQL\ObjectType::class) ??
        $rc->getAttributeClass(\Slack\GraphQL\InterfaceType::class);
    if ($graphql_object) {
        return $graphql_object->getType();
    }

    $graphql_enum = $rc->getAttributeClass(\Slack\GraphQL\EnumType::class);
    if ($graphql_enum) {
        return $graphql_enum->getOutputType();
    }

    return null;
}

/**
 * Shared logic for the above.
 */
function unwrap_type(string $hack_type, bool $nullable = false): (string, string) {
    if (Str\starts_with($hack_type, '?')) {
        return unwrap_type(Str\strip_prefix($hack_type, '?'), true);
    }
    if (Str\starts_with($hack_type, 'HH\vec<')) {
        list($unwrapped, $suffix) = unwrap_type(Str\strip_prefix($hack_type, 'HH\vec<') |> Str\strip_suffix($$, '>'));
        return tuple($unwrapped, $suffix.($nullable ? '->nullableListOf()' : '->nonNullableListOf()'));
    }
    return tuple($hack_type, $nullable ? '::nullable()' : '::nonNullable()');
}
