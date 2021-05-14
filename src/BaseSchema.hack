namespace Slack\GraphQL;

use namespace HH\Lib\Str;

use namespace HH\Lib\{Vec, Dict};

// TODO: this should be private
abstract class BaseSchema implements Introspection\IntrospectableSchema {
    const ?classname<\Slack\GraphQL\Types\ObjectType> MUTATION_TYPE = null;

    abstract const classname<\Slack\GraphQL\Types\ObjectType> QUERY_TYPE;
    abstract const dict<string, classname<Types\NamedInputType>> INPUT_TYPES;
    abstract const dict<string, classname<Types\NamedOutputType>> OUTPUT_TYPES;

    abstract public static function resolveQuery(
        \Graphpinator\Parser\Operation\Operation $operation,
        Variables $variables,
    ): Awaitable<ValidFieldResult<?dict<string, mixed>>>;

    /**
    * Mutations are optional, if the schema supports it, this method will be
    * overwritten in the generated class.
    */
    public static async function resolveMutation(
        \Graphpinator\Parser\Operation\Operation $operation,
        Variables $variables,
    ): Awaitable<ValidFieldResult<?dict<string, mixed>>> {
        return new ValidFieldResult(null);
    }

    private static function getIntrospectableTypes(): dict<string, classname<Introspection\IntrospectableObject>> {
        return Dict\merge(static::INPUT_TYPES, static::OUTPUT_TYPES);
    }

    final public static function getTypes(): vec<Introspection\IntrospectableType> {
        return self::getIntrospectableTypes()
            |> Vec\map($$, $type ==> $type::literal());
    }

    final public static function getType(string $name): ?Introspection\IntrospectableType {
        $type = self::getIntrospectableTypes()[$name] ?? null;
        return $type is nonnull ? $type::literal() : null;
    }

    final public static function getQueryType(): Introspection\IntrospectableType {
        $query = static::QUERY_TYPE;
        return $query::literal();
    }

    final public static function getMutationType(): ?Introspection\IntrospectableType {
        $mutation = static::MUTATION_TYPE;
        return $mutation is nonnull ? $mutation::literal() : null;
    }

}
