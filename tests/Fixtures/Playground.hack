


use namespace Slack\GraphQL;
use type Directives\HasRole;
use type Directives\{TestShapeDirective};
use namespace HH\Lib\{C, Math, Str, Vec};

<<GraphQL\InputObjectType('CreateTeamInput', 'Arguments for creating a team')>>
type TCreateTeamInput = shape(
    'name' => string,
);

<<GraphQL\InputObjectType('CreateUserInput', 'Arguments for creating a user')>>
type TCreateUserInput = shape(
    'name' => string,
    ?'is_active' => ?bool,
    ?'team' => ?TCreateTeamInput,
    ?'favorite_color' => ?FavoriteColor,
);

final class TeamStore {
    private static ?TeamStore $store;

    private dict<int, Team> $teams;
    private function __construct() {
        $this->teams = dict[
            1 => new Team(shape('id' => 1, 'name' => 'Test Team 1', 'num_users' => 3)),
        ];
    }

    public static function getInstance(): this {
        if (self::$store is null) {
            self::$store = new self();
        }
        return self::$store;
    }

    public async function getById(int $id): Awaitable<Team> {
        return $this->teams[$id];
    }

    public async function createTeam(TCreateTeamInput $input): Awaitable<Team> {
        $team = new Team(shape('id' => 2, 'name' => $input['name'], 'num_users' => 1));
        $this->teams[2] = $team;
        return $team;
    }
}

<<GraphQL\InterfaceType('User', 'User'), Directives\AnotherDirective>>
interface User {
    <<GraphQL\Field('id', 'ID of the user')>>
    public function getId(): int;

    <<GraphQL\Field('name', 'Name of the user')>>
    public function getName(): string;

    <<GraphQL\Field('team', 'Team the user belongs to')>>
    public function getTeam(): Awaitable<\Team>;

    <<GraphQL\Field('is_active', 'Whether the user is active')>>
    public function isActive(): bool;
}

abstract class BaseUser implements User {
    public function __construct(
        private shape(
            'id' => int,
            'name' => string,
            'team_id' => int,
            'is_active' => bool,
        ) $data,
    ) {}

    public function getId(): int {
        return $this->data['id'];
    }

    public function getName(): string {
        return $this->data['name'];
    }

    public async function getTeam(): Awaitable<\Team> {
        return await TeamStore::getInstance()->getById($this->data['team_id']);
    }

    public function isActive(): bool {
        return $this->data['is_active'];
    }
}

<<GraphQL\EnumType('FavoriteColor', 'Favorite Color')>>
enum FavoriteColor: int {
    RED = 1;
    BLUE = 2;
}

<<
    GraphQL\ObjectType('Human', 'Human'),
    HasRole(vec[Directives\AdminRoleType::class]),
    Directives\LogSampled(0.0, 'bar'),
>>
final class Human extends BaseUser {
    <<
        GraphQL\Field('favorite_color', 'Favorite color of the user'),
        HasRole(vec[Directives\StaffRoleType::class]),
        \Directives\LogSampled(33.3, 'foo'),
        TestShapeDirective(shape('foo' => 1, 'bar' => 'abc'), true),
        Directives\AnotherDirective,
    >>
    public function getFavoriteColor(): FavoriteColor {
        return FavoriteColor::BLUE;
    }

    <<GraphQL\Field('friends', 'Friends')>>
    public async function getFriends(): Awaitable<UserConnection> {
        return new UserConnection();
    }

    <<GraphQL\Field('named_friends', 'Test that we can pass args to a field which returns a connection')>>
    public async function getFriendsWithArg(string $name_prefix): Awaitable<UserConnection> {
        return new UserConnection($name_prefix);
    }
}

<<GraphQL\ObjectType('Bot', 'Bot')>>
final class Bot extends BaseUser {
    <<GraphQL\Field('primary_function', 'Intended use of the bot')>>
    public function getPrimaryFunction(): string {
        return 'send spam';
    }
}

<<GraphQL\ObjectType('Team', 'Team')>>
final class Team {
    public function __construct(private shape('id' => int, 'name' => string, 'num_users' => int) $data) {}

    <<GraphQL\Field('id', 'ID of the team')>>
    public function getId(): int {
        return $this->data['id'];
    }

    <<GraphQL\Field('name', 'Name of the team')>>
    public function getName(): string {
        return $this->data['name'];
    }

    <<GraphQL\Field('num_users', 'Number of users on the team')>>
    public async function getNumUsers(): Awaitable<int> {
        return $this->data['num_users'];
    }

    <<GraphQL\Field('description', 'Description of the team')>>
    public function getDescription(bool $short): string {
        return $short ? 'Short description' : 'Much longer description';
    }
}

abstract final class UserQueryAttributes {
    <<GraphQL\QueryRootField('viewer', 'Authenticated viewer')>>
    public static async function getViewer(): Awaitable<\User> {
        return new \Human(shape('id' => 1, 'name' => 'Test User', 'team_id' => 1, 'is_active' => true));
    }

    <<GraphQL\QueryRootField('user', 'Fetch a user by ID')>>
    public static async function getUser(int $id): Awaitable<\User> {
        return new \Human(shape('id' => $id, 'name' => 'User '.$id, 'team_id' => 1, 'is_active' => true));
    }

    <<GraphQL\QueryRootField('human', 'Fetch a user by ID')>>
    public static async function getHuman(int $id): Awaitable<\Human> {
        return new \Human(shape('id' => $id, 'name' => 'User '.$id, 'team_id' => 1, 'is_active' => true));
    }

    <<GraphQL\QueryRootField('bot', 'Fetch a bot by ID'), \Directives\LogSampled(1.1, 'foo')>>
    public static async function getBot(int $id): Awaitable<\Bot> {
        return new \Bot(shape('id' => $id, 'name' => 'User '.$id, 'team_id' => 1, 'is_active' => true));
    }

    <<GraphQL\QueryRootField('nested_list_sum', 'Test for nested list arguments')>>
    public static function getNestedListSum(vec<vec<int>> $numbers): int {
        return Math\sum(Vec\map($numbers, $inner ==> Math\sum($inner)));
    }

    <<GraphQL\QueryRootField('takes_favorite_color', 'Test for enum arguments')>>
    public static function takesFavoriteColor(FavoriteColor $favorite_color): bool {
        return true;
    }

    <<GraphQL\QueryRootField('optional_field_test', 'Test for an optional input object field')>>
    public static function optionalFieldTest(TCreateUserInput $input): string {
        if (!Shapes::keyExists($input, 'favorite_color')) {
            return 'color is missing';
        }
        return $input['favorite_color'] is null ? 'color is null' : 'color is non-null';
    }

    <<GraphQL\QueryRootField('alphabetConnection', 'Test for list connection')>>
    public static function alphabetConnection(): AlphabetConnection {
        return new AlphabetConnection();
    }

    <<GraphQL\QueryRootField('allFooObjects', 'Get all foo objects')>>
    public static function allFooObjects(): Foo\FooConnection {
        return new Foo\FooConnection();
    }

    <<GraphQL\QueryRootField('getFoo', 'Get the one foo object')>>
    public static function getFoo(): Foo\FooObject {
        return new Foo\FooObject();
    }

    <<GraphQL\QueryRootField('getBaz', 'Get the one baz object')>>
    public static function getBaz(): Foo\Bar\Baz {
        return new Foo\Bar\Baz();
    }
}

abstract final class UserMutationAttributes {
    <<GraphQL\MutationRootField('pokeUser', 'Poke a user by ID')>>
    public static async function pokeUser(int $id): Awaitable<\User> {
        return new \Human(shape('id' => $id, 'name' => 'User '.$id, 'team_id' => 1, 'is_active' => true));
    }

    <<
        GraphQL\MutationRootField('createUser', 'Create a new user'),
        \Directives\HasRole(vec[\Directives\StaffRoleType::class]),
    >>
    public static async function createUser(TCreateUserInput $input): Awaitable<\User> {
        $team_input = $input['team'] ?? null;

        $team = null;
        if ($team_input is nonnull) {
            $team = await TeamStore::getInstance()->createTeam($team_input);
        }

        return new \Human(shape(
            'id' => 3,
            'name' => $input['name'],
            'is_active' => $input['is_active'] ?? true,
            'team_id' => $team?->getId() ?? 1,
        ));
    }
}


final class AlphabetConnection extends GraphQL\Pagination\ListConnection {
    const type TNode = string;

    public function __construct() {
        parent::__construct(Str\split('abcdefghijklmnopqrstuvwxyz', ''));
    }
}
