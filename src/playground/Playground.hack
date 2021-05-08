/**

SCHEMA:

type Team {
    id: Int
    name: String
}

type User {
    id: Int
    name: String
    team: Team
}

type Query {
    viewer: User
    user(id: Int!): User
}

schema {
    query: Query
}

QUERY:

query {
    viewer {
        id
        name
        team {
            id
            name
        }
    }
}

*/

use namespace Slack\GraphQL;
use namespace HH\Lib\{Math, Vec};

<<__Memoize>>
function getTeams(): dict<int, Team> {
    return dict[
        1 => new Team(shape('id' => 1, 'name' => 'Test Team 1', 'num_users' => 3)),
    ];
}

<<GraphQL\Object('User', 'User')>>
final class User {
    public function __construct(private shape('id' => int, 'name' => string, 'team_id' => int) $data) {}

    <<GraphQL\Field('id', 'ID of the user')>>
    public function getId(): int {
        return $this->data['id'];
    }

    <<GraphQL\Field('name', 'Name of the user')>>
    public function getName(): string {
        return $this->data['name'];
    }

    <<GraphQL\Field('team', 'Team the user belongs to')>>
    public async function getTeam(): Awaitable<\Team> {
        return getTeams()[$this->data['team_id']];
    }

    <<GraphQL\Field('isAdmin', 'Boolean for whether the user is an admin')>>
    public function isAdmin(): bool {
        return $this->data['id'] > 1;
    }
}

<<GraphQL\Object('Team', 'Team')>>
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

    <<GraphQL\Field('numUsers', 'Number of users on the team')>>
    public async function getNumUsers(bool $include_admins): Awaitable<int> {
        return $this->data['num_users'];
    }
}

abstract final class UserQueryAttributes {
    <<GraphQL\QueryRootField('viewer', 'Authenticated viewer')>>
    public static async function getViewer(): Awaitable<\User> {
        return new \User(shape('id' => 1, 'name' => 'Test User', 'team_id' => 1));
    }

    <<GraphQL\QueryRootField('user', 'Fetch a user by ID')>>
    public static async function getUser(int $id): Awaitable<\User> {
        return new \User(shape('id' => $id, 'name' => 'User '.$id, 'team_id' => 1));
    }

    <<GraphQL\QueryRootField('nested_list_sum', 'Test for nested list arguments')>>
    public static function getNestedListSum(vec<vec<int>> $numbers): int {
        return Math\sum(Vec\map($numbers, $inner ==> Math\sum($inner)));
    }
}
