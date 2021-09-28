


use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;
use namespace Slack\GraphQL;

abstract class BaseTest extends \Facebook\HackTest\HackTest {
    abstract const type TTestCases;

    abstract public static function getTestCases(): this::TTestCases;

    <<__Override>>
    public static async function beforeFirstTestAsync(): Awaitable<void> {
        await self::runCodegenAsync();
    }

    <<__Memoize>>
    private static async function runCodegenAsync(): Awaitable<void> {
        $start_ts = microtime(true);
        await GraphQL\Codegen\Generator::forPath(
            __DIR__.'/Fixtures',
            shape(
                'output_directory' => __DIR__.'/gen',
                'namespace' => 'Slack\GraphQL\Test\Generated',
                'custom_directives' => shape(
                    'fields' => keyset[
                        Directives\AnotherDirective::class,
                        Directives\HasRole::class,
                        Directives\LogSampled::class,
                        Directives\TestShapeDirective::class,
                    ],
                    'objects' => keyset[
                        Directives\AnotherDirective::class,
                        Directives\HasRole::class,
                        Directives\LogSampled::class,
                    ],
                ),
            ),
        );
        echo "Generated fixtures in: ".(microtime(true) - $start_ts)."\n";
    }

    private function getResolver(GraphQL\Resolver::TOptions $options = shape()): GraphQL\Resolver {
        return new GraphQL\Resolver(new \Slack\GraphQL\Test\Generated\Schema(), $options);
    }

    public async function resolve(
        string $query,
        dict<string, mixed> $variables = dict[],
        GraphQL\Resolver::TOptions $options = shape(),
    ): Awaitable<GraphQL\Resolver::TResponse> {
        $resolver = $this->getResolver($options);
        return await $resolver->resolve($query, $variables);
    }
}
