use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;
use namespace Slack\GraphQL;

final class PlaygroundTest extends \Facebook\HackTest\HackTest {

    public static async function beforeFirstTestAsync(): Awaitable<void> {
        $gen = new GraphQL\Codegen\Generator();

        $from_path = __DIR__.'/../src/playground/Playground.hack';
        $to_path = __DIR__.'/gen/Generated.hack';
        await $gen->generate($from_path, $to_path);
    }

    public async function testSelectTeamId(): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource('query { viewer { id, team { id } } }');
        $parser = new \Graphpinator\Parser\Parser($source);

        $request = $parser->parse();
        $resolver = new GraphQL\Resolver(\Slack\GraphQL\Test\Generated\Schema::class);

        $out = await $resolver->resolve($request);
        expect(($out['data'] as dynamic)['query']['viewer']['id'])->toBeSame(1);
        expect(($out['data'] as dynamic)['query']['viewer']['team']['id'])->toBeSame(1);
    }

    public async function testSelectTeamName(): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource('query { viewer { team { name, num_users } } }');
        $parser = new \Graphpinator\Parser\Parser($source);

        $request = $parser->parse();
        $resolver = new GraphQL\Resolver(\Slack\GraphQL\Test\Generated\Schema::class);

        $out = await $resolver->resolve($request);
        expect(($out['data'] as dynamic)['query']['viewer']['team']['name'])->toBeSame('Test Team 1');
        expect(($out['data'] as dynamic)['query']['viewer']['team']['num_users'])->toBeSame(3);
    }
}
