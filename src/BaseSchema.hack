namespace Slack\GraphQL;

// TODO: this should be private
abstract class BaseSchema {
    const SUPPORTS_MUTATIONS = false;
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
}
