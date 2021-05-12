namespace Slack\GraphQL;

// TODO: this should be private
abstract class BaseSchema {
    const SUPPORTS_MUTATIONS = false;

    abstract public static function resolveQuery(
        \Graphpinator\Parser\Operation\Operation $operation,
        __Private\Variables $variables,
    ): Awaitable<ValidFieldResult<?dict<string, mixed>>>;

    /**
    * Mutations are optional, if the schema supports it, this method will be
    * overwritten in the generated class.
    */
    public static async function resolveMutation(
        \Graphpinator\Parser\Operation\Operation $operation,
        __Private\Variables $variables,
    ): Awaitable<ValidFieldResult<?dict<string, mixed>>> {
        return new ValidFieldResult(null);
    }
}
