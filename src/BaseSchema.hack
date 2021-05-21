namespace Slack\GraphQL;

use namespace HH\Lib\{Dict, Vec, Str};

// TODO: this should be private
<<__ConsistentConstruct>>
abstract class BaseSchema implements Introspection\__Schema, \HH\IMemoizeParam {
    const ?classname<\Slack\GraphQL\Types\ObjectType> MUTATION_TYPE = null;
    abstract const classname<\Slack\GraphQL\Types\ObjectType> QUERY_TYPE;

    abstract const dict<string, classname<Types\NamedType>> TYPES;

    abstract public function resolveQuery(
        \Graphpinator\Parser\Operation\Operation $operation,
        Variables $variables,
    ): Awaitable<ValidFieldResult<?dict<string, mixed>>>;

    /**
    * Mutations are optional, if the schema supports it, this method will be
    * overwritten in the generated class.
    */
    public async function resolveMutation(
        \Graphpinator\Parser\Operation\Operation $operation,
        Variables $variables,
    ): Awaitable<ValidFieldResult<?dict<string, mixed>>> {
        return new ValidFieldResult(null);
    }

    final public function getQueryType(): Types\ObjectType {
        $query_type = static::QUERY_TYPE;
        return $query_type::nonNullable($this);
    }

    final public function getMutationType(): ?Types\ObjectType {
        $mutation_type = static::MUTATION_TYPE;
        return $mutation_type is nonnull ? $mutation_type::nonNullable($this) : null;
    }

    <<__Override>>
    final public function getIntrospectionQueryType(): Introspection\__Type {
        $query_type = static::QUERY_TYPE;
        return $query_type::nullableOutput($this);
    }

    <<__Override>>
    final public function getIntrospectionMutationType(): ?Introspection\__Type {
        $mutation_type = static::MUTATION_TYPE;
        return $mutation_type is nonnull ? $mutation_type::nullableOutput($this) : null;
    }

    final public function getIntrospectionType(string $name): ?Introspection\__Type {
        $type = static::TYPES[$name] ?? null;
        return $type is nonnull ? $type::nonNullable($this)->nullableForIntrospection() : null;
    }

    final public function getInstanceKey(): string {
        return Vec\keys(static::TYPES) |> Str\join($$, '');
    }
}
