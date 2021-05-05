use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;
use namespace Slack\GraphQL;

final class PlaygroundTest extends \Facebook\HackTest\HackTest {
    public async function testSelectTeamId(): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource('query { viewer { id, team { id } } }');
        $parser = new \Graphpinator\Parser\Parser($source);

        $request = $parser->parse();
        $out = await \Generated\Resolver::resolve($request);
        expect(($out['data'] as dynamic)['query']['viewer']['id'])->toBeSame(1);
        expect(($out['data'] as dynamic)['query']['viewer']['team']['id'])->toBeSame(1);
    }

    public async function testSelectTeamName(): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource('query { viewer { team { name } } }');
        $parser = new \Graphpinator\Parser\Parser($source);

        $request = $parser->parse();
        $out = await \Generated\Resolver::resolve($request);
        expect(($out['data'] as dynamic)['query']['viewer']['team']['name'])->toBeSame('Test Team 1');
    }

    public async function testGenerator(): Awaitable<void> {
        await GraphQL\Generator::generate();
    }
}
