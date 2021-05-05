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

final class User {
    public function __construct(private shape('id' => int, 'name' => string, 'team_id' => int) $data) {}

    public function getId(): int {
        return $this->data['id'];
    }

    public function getName(): string {
        return $this->data['name'];
    }

    public function getTeam(): \Team {
        return getTeams()[$this->data['team_id']];
    }
}

final class Team {
    public function __construct(private shape('id' => int, 'name' => string) $data) {}

    public function getId(): int {
        return $this->data['id'];
    }

    public function getName(): string {
        return $this->data['name'];
    }
}
