namespace Slack\GraphQL;

use namespace HH\Lib\{Dict, Keyset, Vec, Str};

// TODO: this should be private
<<__ConsistentConstruct>>
abstract class BaseSchema implements Introspection\__Schema {
    const ?classname<\Slack\GraphQL\Types\ObjectType> MUTATION_TYPE = null;
    abstract const classname<\Slack\GraphQL\Types\ObjectType> QUERY_TYPE;

    abstract const dict<string, classname<Types\NamedType>> TYPES;

    abstract public function resolveQuery(
        \Graphpinator\Parser\Operation\Operation $operation,
        ExecutionContext $context,
    ): Awaitable<ValidFieldResult<?dict<string, mixed>>>;

    /**
    * Mutations are optional, if the schema supports it, this method will be
    * overwritten in the generated class.
    */
    public async function resolveMutation(
        \Graphpinator\Parser\Operation\Operation $operation,
        ExecutionContext $context,
    ): Awaitable<ValidFieldResult<?dict<string, mixed>>> {
        return new ValidFieldResult(null);
    }

    final public function getQueryType(): Types\ObjectType {
        $query_type = static::QUERY_TYPE;
        return $query_type::nonNullable();
    }

    final public function getMutationType(): ?Types\ObjectType {
        $mutation_type = static::MUTATION_TYPE;
        return $mutation_type is nonnull ? $mutation_type::nonNullable() : null;
    }

    <<__Override>>
    final public function getIntrospectionQueryType(): Introspection\__Type {
        return $this->getQueryType()->nullableForIntrospection();
    }

    <<__Override>>
    final public function getIntrospectionMutationType(): ?Introspection\__Type {
        return $this->getMutationType()?->nullableForIntrospection();
    }

    final public function getType(string $name): ?Types\NamedType {
        $type = static::TYPES[$name] ?? null;
        return $type is nonnull ? $type::nonNullable() : null;
    }

    final public function getIntrospectionType(string $name): ?Introspection\__Type {
        return $this->getType($name)?->nullableForIntrospection();
    }

    <<__Override>>
    final public function getTypes(): vec<Introspection\__Type> {
        return Dict\filter_keys(static::TYPES, $name ==> !Str\starts_with($name, '__'))
            |> Vec\map_with_key(static::TYPES, ($name, $_) ==> $this->getIntrospectionType($name) as nonnull);
    }
}
