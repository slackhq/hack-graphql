use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;
use namespace Slack\GraphQL;

final class PlaygroundTest extends \Facebook\HackTest\HackTest {

    public static async function beforeFirstTestAsync(): Awaitable<void> {
        $gen = new GraphQL\Codegen\Generator();

        $from_path = __DIR__.'/../src/playground/Playground.hack';
        $to_path = __DIR__.'/gen/Generated.hack';

        $file = await $gen->generate($from_path, $to_path);
        $file->setNamespace('Slack\GraphQL\Test\Generated');
        $file->save();
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

    public async function testSelectIsActive(): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource('query { viewer { is_active } }');
        $parser = new \Graphpinator\Parser\Parser($source);

        $request = $parser->parse();
        $resolver = new GraphQL\Resolver(\Slack\GraphQL\Test\Generated\Schema::class);

        $out = await $resolver->resolve($request);
        expect(($out['data'] as dynamic)['query']['viewer']['is_active'])->toBeTrue();
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

    public async function testVariables(): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource('query TestQuery($user_id: ID!) { user(id: $user_id) { id } }');
        $parser = new \Graphpinator\Parser\Parser($source);
        $resolver = new GraphQL\Resolver(\Slack\GraphQL\Test\Generated\Schema::class);

        $request = $parser->parse();
        $out = await $resolver->resolve($request, dict['user_id' => 3]);
        expect(($out['data'] as dynamic)['query']['user']['id'])->toBeSame(3);
    }

    public async function testNestedVariable(): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource(
            'query TestQuery($num: Int!) { nested_list_sum(numbers: [21, [$num, 14]]) }',
        );
        $parser = new \Graphpinator\Parser\Parser($source);
        $resolver = new GraphQL\Resolver(\Slack\GraphQL\Test\Generated\Schema::class);

        $request = $parser->parse();
        $out = await $resolver->resolve($request, dict['num' => 7]);
        expect(($out['data'] as dynamic)['query']['nested_list_sum'])->toBeSame(42);
    }

    public async function testInlineArguments(): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource('query { user(id: 2) { id } }');
        $parser = new \Graphpinator\Parser\Parser($source);
        $resolver = new GraphQL\Resolver(\Slack\GraphQL\Test\Generated\Schema::class);

        $request = $parser->parse();
        $out = await $resolver->resolve($request);
        expect(($out['data'] as dynamic)['query']['user']['id'])->toBeSame(2);
    }

    public async function testSelectConcreteImplementation(): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource('query { human(id: 2) { id, name, favorite_color } }');
        $parser = new \Graphpinator\Parser\Parser($source);

        $request = $parser->parse();
        $resolver = new GraphQL\Resolver(\Slack\GraphQL\Test\Generated\Schema::class);

        $out = await $resolver->resolve($request);
        expect(($out['data'] as dynamic)['query']['human']['id'])->toBeSame(2);
        expect(($out['data'] as dynamic)['query']['human']['name'])->toBeSame('User 2');
        expect(($out['data'] as dynamic)['query']['human']['favorite_color'])->toBeSame('blue');
    }

    public async function testSelectInvalidFieldOnInterface(): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource('query { user(id: 2) { id, name, favorite_color } }');
        $parser = new \Graphpinator\Parser\Parser($source);

        $request = $parser->parse();
        $resolver = new GraphQL\Resolver(\Slack\GraphQL\Test\Generated\Schema::class);

        expect(async () ==> await $resolver->resolve($request))
            ->toThrow(\Exception::class, "Unknown field: favorite_color");
    }

    public async function testSelectInvalidFieldOnConcreteImplementation(): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource('query { bot(id: 2) { id, name, favorite_color } }');
        $parser = new \Graphpinator\Parser\Parser($source);

        $request = $parser->parse();
        $resolver = new GraphQL\Resolver(\Slack\GraphQL\Test\Generated\Schema::class);

        expect(async () ==> await $resolver->resolve($request))
            ->toThrow(\Exception::class, "Unknown field: favorite_color");
    }

    public async function testBooleanInput(): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource(
            'query TestQuery($short: Boolean!) { user(id: 2) { id, team { description(short: $short) } } }'
        );
        $parser = new \Graphpinator\Parser\Parser($source);
        $resolver = new GraphQL\Resolver(\Slack\GraphQL\Test\Generated\Schema::class);

        $request = $parser->parse();
        $out = await $resolver->resolve($request, dict['short' => true]);
        expect(($out['data'] as dynamic)['query']['user']['team']['description'])->toBeSame("Short description");

        $out = await $resolver->resolve($request, dict['short' => false]);
        expect(($out['data'] as dynamic)['query']['user']['team']['description'])->toBeSame("Much longer description");
    }
}
