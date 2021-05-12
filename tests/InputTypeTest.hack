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
                    'input' => dict[
                        'name' => 'New User',
                    ],
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
                    'input' => dict[
                        'name' => 'New User',
                        'is_active' => false,
                    ],
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
                    'input' => dict[
                        'name' => 'New User',
                        'team' => dict[
                            'name' => 'New Team',
                        ],
                    ],
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
        ];
    }

}
