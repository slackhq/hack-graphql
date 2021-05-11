use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;
use namespace Slack\GraphQL;

abstract class PlaygroundTest extends \Facebook\HackTest\HackTest {

    abstract public static function getTestCases(): dict<string, (string, dict<string, mixed>, dict<string, mixed>)>;

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
        dict<string, mixed> $expected_response,
    ): Awaitable<void> {
        if (!C\contains_key($expected_response, 'data')) {
            $expected_response = dict['data' => $expected_response];
        }

        $source = new \Graphpinator\Source\StringSource($query);
        $parser = new \Graphpinator\Parser\Parser($source);

        $request = $parser->parse();
        $resolver = new GraphQL\Resolver(\Slack\GraphQL\Test\Generated\Schema::class);

        $out = await $resolver->resolve($request, $variables);
        expect($out)->toEqual($expected_response);
    }
}
