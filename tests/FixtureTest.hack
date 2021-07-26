


use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;
use namespace Slack\GraphQL;

abstract class FixtureTest extends \Facebook\HackTest\HackTest {

    const type TTestCases = dict<string, (string, dict<string, mixed>, mixed)>;

    abstract public static function getTestCases(): this::TTestCases;

    <<__Override>>
    public static async function beforeFirstTestAsync(): Awaitable<void> {
        await self::runCodegenAsync();
    }

    <<__Memoize>>
    private static async function runCodegenAsync(): Awaitable<void> {
        await GraphQL\Codegen\Generator::forPath(
            __DIR__.'/Fixtures',
            shape(
                'output_directory' => __DIR__.'/gen',
                'namespace' => 'Slack\GraphQL\Test\Generated',
            ),
        );
    }

    <<\Facebook\HackTest\DataProvider('getTestCases')>>
    final public async function test(
        string $query,
        dict<string, mixed> $variables,
        mixed $expected_response,
    ): Awaitable<void> {
        // If $expected_response is not a shape with 'data' and/or 'errors', assume it's the data.
        if (
            !$expected_response is shape('data' => mixed, ...) && !$expected_response is shape('errors' => mixed, ...)
        ) {
            $expected_response = shape('data' => $expected_response);
        }

        $out = await $this->resolve($query, $variables);
        expect($out)->toHaveSameShapeAs($expected_response);
    }

    private function getResolver(): GraphQL\Resolver {
        return new GraphQL\Resolver(new \Slack\GraphQL\Test\Generated\Schema());
    }

    public async function resolve(
        string $query,
        dict<string, mixed> $variables = dict[],
        bool $verbose_errors = false,
    ): Awaitable<GraphQL\IResponse::TShape> {
        $request = GraphQL\Request::build($query, $variables);
        $resolver = $this->getResolver();
        $response = await $resolver->resolve($request);
        return $response->toShape($verbose_errors);
    }
}
