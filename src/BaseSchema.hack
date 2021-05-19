namespace Slack\GraphQL;

use namespace HH\Lib\{C, Dict};

// TODO: this should be private
abstract class BaseSchema implements Introspection\__Schema {
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

    final public static function getQueryType(): Types\ObjectType {
        $query_type = static::QUERY_TYPE;
        return new $query_type();
    }

    final public static function getMutationType(): ?Types\ObjectType {
        $mutation_type = static::MUTATION_TYPE;
        return $mutation_type is nonnull ? new $mutation_type() : null;
    }

    <<__Override>>
    final public function getIntrospectionQueryType(): Introspection\__Type {
        $query_type = static::QUERY_TYPE;
        return $query_type::introspect($this);
    }

    <<__Override>>
    final public function getIntrospectionMutationType(): ?Introspection\__Type {
        $mutation_type = static::MUTATION_TYPE;
        return $mutation_type is nonnull ? $mutation_type::introspect($this) : null;
    }

    <<__Override>>
    final public function getIntrospectionType(string $name): ?Introspection\NamedTypeDeclaration {
        $class = static::OUTPUT_TYPES[$name] ?? null;
        if ($class is nonnull) {
            return $class::introspect($this);
        }
        $class = static::INPUT_TYPES[$name] ?? null;
        if ($class is null) {
            return null;
        }
        $type = $class::nonNullable() as Types\InputObjectType;
        return $type::introspect($this);
    }

    <<__Override>>
    public function getIntrospectionTypes(): vec<Introspection\__Type> {
        $types = dict[];
        foreach (static::OUTPUT_TYPES as $name => $class) {
            $types[$name] = $this->getIntrospectionType($name) as nonnull;
        }
        foreach (static::INPUT_TYPES as $name => $class) {
            if (!C\contains_key($types, $name)) {
                $types[$name] = $this->getIntrospectionType($name) as nonnull;
            }
        }
        return vec($types);
    }

    // TODO add method to create singleton
}
