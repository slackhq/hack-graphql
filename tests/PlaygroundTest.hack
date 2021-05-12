use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;
use namespace Slack\GraphQL;

abstract class PlaygroundTest extends \Facebook\HackTest\HackTest {

    const type TTestCases = dict<string, (string, dict<string, mixed>, mixed)>;

    abstract public static function getTestCases(): this::TTestCases;

    <<__Override>>
    public static async function beforeFirstTestAsync(): Awaitable<void> {
        await self::runCodegenAsync();
    }

    <<__Memoize>>
    private static async function runCodegenAsync(): Awaitable<void> {
        $file = await GraphQL\Codegen\Generator::forPath(
            __DIR__.'/../src/playground',
            shape(
                'output_path' => __DIR__.'/gen/Generated.hack',
            ),
        );

        $file->setNamespace('Slack\GraphQL\Test\Generated');
        $file->save();
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

        $source = new \Graphpinator\Source\StringSource($query);
        $parser = new \Graphpinator\Parser\Parser($source);

        $request = $parser->parse();
        $resolver = new GraphQL\Resolver(\Slack\GraphQL\Test\Generated\Schema::class);

        $out = await $resolver->resolve($request, $variables);
        expect($out)->toHaveSameShapeAs($expected_response);
    }
}
