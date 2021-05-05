use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;

final class PlaygroundTest extends \Facebook\HackTest\HackTest {
    public function testSelectTeamId(): void {
        $source = new \Graphpinator\Source\StringSource('query { viewer { id, team { id } } }');
        $parser = new \Graphpinator\Parser\Parser($source);

        $request = $parser->parse();
        $out = \Generated\Resolver::resolve($request);
        expect(($out['data'] as dynamic)['query']['viewer']['id'])->toBeSame(1);
        expect(($out['data'] as dynamic)['query']['viewer']['team']['id'])->toBeSame(1);
    }

    public function testSelectTeamName(): void {
        $source = new \Graphpinator\Source\StringSource('query { viewer { team { name } } }');
        $parser = new \Graphpinator\Parser\Parser($source);

        $request = $parser->parse();
        $out = \Generated\Resolver::resolve($request);
        expect(($out['data'] as dynamic)['query']['viewer']['team']['name'])->toBeSame('Test Team 1');
    }
}
