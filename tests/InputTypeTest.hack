use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;
use namespace Slack\GraphQL;

/**
* Test GraphQL mutations with input types.
*/
final class InputTypeTest extends PlaygroundTest {
    <<__Override>>
    public static function getTestCases(): this::TTestCases {
        return dict[
            "simple input type, don't provide field with default" => tuple(
                'mutation CreateUser($input: CreateUserInput!) {
                    createUser(input: $input) {
                        id
                        is_active
                        name
                        team {
                            name
                        }
                    }
                }',
                dict[
                    'input' => shape(
                        'name' => 'New User',
                    ),
                ],
                dict[
                    'createUser' => dict[
                        'id' => 3,
                        'name' => 'New User',
                        'is_active' => true,
                        'team' => dict[
                            'name' => 'Test Team 1',
                        ],
                    ],
                ],
            ),
            "simple input type, provide field with default" => tuple(
                'mutation CreateUser($input: CreateUserInput!) {
                    createUser(input: $input) {
                        id
                        is_active
                        name
                        team {
                            name
                        }
                    }
                }',
                dict[
                    'input' => shape(
                        'name' => 'New User',
                        'is_active' => false,
                    ),
                ],
                dict[
                    'createUser' => dict[
                        'id' => 3,
                        'name' => 'New User',
                        'is_active' => false,
                        'team' => dict[
                            'name' => 'Test Team 1',
                        ],
                    ],
                ],
            ),
            "complex input type" => tuple(
                'mutation CreateUser($input: CreateUserInput!) {
                    createUser(input: $input) {
                        id
                        is_active
                        name
                        team {
                            name
                        }
                    }
                }',
                dict[
                    'input' => shape(
                        'name' => 'New User',
                        'team' => shape(
                            'name' => 'New Team',
                        ),
                    ),
                ],
                dict[
                    'createUser' => dict[
                        'id' => 3,
                        'name' => 'New User',
                        'is_active' => true,
                        'team' => dict[
                            'name' => 'New Team',
                        ],
                    ],
                ],
            ),

            'input object literal' => tuple(
                'mutation CreateUser {
                    createUser(input: {
                        name: "New User"
                        is_active: false
                        team: {name: "New Team"}
                        favorite_color: RED
                    }) {
                        id
                        is_active
                        name
                        team { name }
                    }
                }',
                dict[],
                dict[
                    'createUser' => dict[
                        'id' => 3,
                        'is_active' => false,
                        'name' => 'New User',
                        'team' => dict['name' => 'New Team'],
                    ],
                ],
            ),

            'input object literal with variable references' => tuple(
                'mutation CreateUser(
                    $name: String!
                    $is_active: Boolean!
                    $team_name: String!
                    $favorite_color: FavoriteColor!
                ) {
                    createUser(input: {
                        name: $name
                        is_active: $is_active
                        team: {name: $team_name}
                        favorite_color: $favorite_color
                    }) {
                        id
                        is_active
                        name
                        team { name }
                    }
                }',
                dict[
                    'name' => 'New User',
                    'is_active' => false,
                    'team_name' => 'New Team',
                    'favorite_color' => 'RED',
                ],
                dict[
                    'createUser' => dict[
                        'id' => 3,
                        'is_active' => false,
                        'name' => 'New User',
                        'team' => dict['name' => 'New Team'],
                    ],
                ],
            ),

            'nested input object variable' => tuple(
                'mutation CreateUser(
                    $team: CreateTeamInput!
                ) {
                    createUser(input: {
                        name: "New User"
                        is_active: false
                        team: $team
                        favorite_color: RED
                    }) {
                        id
                        is_active
                        name
                        team { name }
                    }
                }',
                dict[
                    'team' => shape('name' => 'New Team'),
                ],
                dict[
                    'createUser' => dict[
                        'id' => 3,
                        'is_active' => false,
                        'name' => 'New User',
                        'team' => dict['name' => 'New Team'],
                    ],
                ],
            ),
        ];
    }

}
