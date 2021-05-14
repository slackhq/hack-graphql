use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;
use namespace Slack\GraphQL;

final class BasicTest extends PlaygroundTest {

    <<__Override>>
    public static function getTestCases(): this::TTestCases {
        return dict[
            'select team.id' => tuple(
                'query { viewer { id, team { id } } }',
                dict[],
                dict['viewer' => dict['id' => 1, 'team' => dict['id' => 1]]],
            ),
            'select is_active' =>
                tuple('query { viewer { is_active } }', dict[], dict['viewer' => dict['is_active' => true]]),
            'select team.name' => tuple(
                'query { viewer { team { name, num_users } } }',
                dict[],
                dict['viewer' => dict['team' => dict['name' => 'Test Team 1', 'num_users' => 3]]],
            ),
            'variables' => tuple(
                'query TestQuery($user_id: Int!) { user(id: $user_id) { id } }',
                dict['user_id' => 3],
                dict['user' => dict['id' => 3]],
            ),
            'variable with default' => tuple(
                'query TestQuery($user_id: Int! = 3) { user(id: $user_id) { id } }',
                dict[],
                dict['user' => dict['id' => 3]],
            ),
            'nested variables' => tuple(
                'query TestQuery($num: Int!) { nested_list_sum(numbers: [21, [$num, 14]]) }',
                dict['num' => 7],
                dict['nested_list_sum' => 42],
            ),
            'inline arguments' => tuple('query { user(id: 2) { id } }', dict[], dict['user' => dict['id' => 2]]),
            'select concrete implementation' => tuple(
                'query { human(id: 2) { id, name, favorite_color } }',
                dict[],
                dict['human' => dict['id' => 2, 'name' => 'User 2', 'favorite_color' => 'BLUE']],
            ),
            'boolean input true' => tuple(
                'query TestQuery($short: Boolean!) { user(id: 2) { id, team { description(short: $short) } } }',
                dict['short' => true],
                dict['user' => dict['id' => 2, 'team' => dict['description' => 'Short description']]],
            ),
            'boolean input false' => tuple(
                'query TestQuery($short: Boolean!) { user(id: 2) { id, team { description(short: $short) } } }',
                dict['short' => false],
                dict['user' => dict['id' => 2, 'team' => dict['description' => 'Much longer description']]],
            ),
            'mutation' => tuple('mutation { pokeUser(id: 2) { id } }', dict[], dict['pokeUser' => dict['id' => 2]]),
            'enum arguments' => tuple(
                'query { takes_favorite_color(favorite_color: RED) }',
                dict[],
                dict['takes_favorite_color' => true],
            ),
            'enum arguments with variables' => tuple(
                'query ($favorite_color: FavoriteColor!) { takes_favorite_color(favorite_color: $favorite_color) }',
                dict['favorite_color' => 'RED'],
                dict['takes_favorite_color' => true],
            ),
        ];
    }

    public async function testSelectInvalidFieldOnInterface(): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource('query { user(id: 2) { id, name, favorite_color } }');
        $parser = new \Graphpinator\Parser\Parser($source);

        $request = $parser->parse();
        // $resolver = new GraphQL\Resolver(\Slack\GraphQL\Test\Generated\Schema::class);

        //     expect(async () ==> await $resolver->resolve($request))
        //         ->toThrow(\Exception::class, "Unknown field: favorite_color");
    }

    public async function testSelectInvalidFieldOnConcreteImplementation(): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource('query { bot(id: 2) { id, name, favorite_color } }');
        $parser = new \Graphpinator\Parser\Parser($source);

        $request = $parser->parse();
        // $resolver = new GraphQL\Resolver(\Slack\GraphQL\Test\Generated\Schema::class);

        // expect(async () ==> await $resolver->resolve($request))
        // ->toThrow(\Exception::class, "Unknown field: favorite_color");
    }

}
