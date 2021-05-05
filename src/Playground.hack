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

<<__Memoize>>
function getTeams(): dict<int, Team> {
    return dict[
        1 => new Team(shape('id' => 1, 'name' => 'Test Team 1')),
    ];
}

<<GraphQLObject('User', 'User')>>
final class User {
    public function __construct(private shape('id' => int, 'name' => string, 'team_id' => int) $data) {}

    <<GraphQLField('id', 'ID of the user')>>
    public function getId(): int {
        return $this->data['id'];
    }

    <<GraphQLField('name', 'Name of the user')>>
    public function getName(): string {
        return $this->data['name'];
    }

    <<GraphQLField('team', 'Team the user belongs to')>>
    public function getTeam(): \Team {
        return getTeams()[$this->data['team_id']];
    }
}

<<GraphQLObject('Team', 'Team')>>
final class Team {
    public function __construct(private shape('id' => int, 'name' => string) $data) {}

    <<GraphQLField('id', 'ID of the team')>>
    public function getId(): int {
        return $this->data['id'];
    }

    <<GraphQLField('name', 'Name of the team')>>
    public function getName(): string {
        return $this->data['name'];
    }
}

abstract final class UserQueryAttributes {
    <<GraphQLQueryRootField('viewer', 'Authenticated viewer')>>
    public static async function getViewer(): Awaitable<\User> {
        return new \User(shape('id' => 1, 'name' => 'Test User', 'team_id' => 1));
    }
}
