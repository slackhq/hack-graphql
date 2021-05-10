use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;
use namespace Slack\GraphQL;

final class PlaygroundTest extends \Facebook\HackTest\HackTest {

    public static async function beforeFirstTestAsync(): Awaitable<void> {
        $gen = new GraphQL\__Private\Codegen\Generator();

        $from_path = __DIR__.'/Playground.hack';
        $to_path = __DIR__.'/gen/Generated.hack';

        $file = await $gen->generate($from_path, $to_path);
        $file->setNamespace('Slack\GraphQL\Test\Generated');
        $file->save();
    }

    private async function resolve(string $query, dict<string, mixed> $vars = dict[]): Awaitable<dynamic> {
        $source = new \Graphpinator\Source\StringSource($query);
        $parser = new \Graphpinator\Parser\Parser($source);

        $request = $parser->parse();
        $resolver = new GraphQL\Resolver(\Slack\GraphQL\Test\Generated\Schema::class);

        return await $resolver->resolve($request, $vars);
    }

    public async function testSelectTeamId(): Awaitable<void> {
        $out = await $this->resolve('query { viewer { id, team { id } } }');
        expect(($out['data'] as dynamic)['query']['viewer']['id'])->toBeSame(1);
        expect(($out['data'] as dynamic)['query']['viewer']['team']['id'])->toBeSame(1);
    }

    public async function testSelectIsActive(): Awaitable<void> {
        $out = await $this->resolve('query { viewer { is_active } }');
        expect(($out['data'] as dynamic)['query']['viewer']['is_active'])->toBeTrue();
    }

    public async function testSelectTeamName(): Awaitable<void> {
        $out = await $this->resolve('query { viewer { team { name, num_users } } }');
        expect(($out['data'] as dynamic)['query']['viewer']['team']['name'])->toBeSame('Test Team 1');
        expect(($out['data'] as dynamic)['query']['viewer']['team']['num_users'])->toBeSame(3);
    }

    public async function testVariables(): Awaitable<void> {
        $out = await $this->resolve(
            'query TestQuery($user_id: ID!) { user(id: $user_id) { id } }',
            dict['user_id' => 3]
        );
        expect(($out['data'] as dynamic)['query']['user']['id'])->toBeSame(3);
    }

    public async function testNestedVariable(): Awaitable<void> {
        $out = await $this->resolve(
            'query TestQuery($num: Int!) { nested_list_sum(numbers: [21, [$num, 14]]) }',
            dict['num' => 7]
        );
        expect(($out['data'] as dynamic)['query']['nested_list_sum'])->toBeSame(42);
    }

    public async function testInlineArguments(): Awaitable<void> {
        $out = await $this->resolve('query { user(id: 2) { id } }');
        expect(($out['data'] as dynamic)['query']['user']['id'])->toBeSame(2);
    }

    public async function testBooleanInput(): Awaitable<void> {
        $query = 'query TestQuery($short: Boolean!) { user(id: 2) { id, team { description(short: $short) } } }';

        $out = await $this->resolve($query, dict['short' => true]);
        expect(($out['data'] as dynamic)['query']['user']['team']['description'])->toBeSame("Short description");

        $out = await $this->resolve($query, dict['short' => false]);
        expect(($out['data'] as dynamic)['query']['user']['team']['description'])->toBeSame("Much longer description");
    }
}
