use function Facebook\FBExpect\expect;

use namespace Slack\GraphQL;

final class FragmentTest extends PlaygroundTest {

    <<__Override>>
    public static function getTestCases(): this::TTestCases {
        return dict[
            'various interesting cases' => tuple(
                '
                    query {
                        one: user(id: 1) { ...BotFrag, ...UserFrag, team { id } }
                        two: bot(id: 2)  { ...BotFrag, ...UserFrag, team { id } }
                    }

                    fragment UserFrag on User {
                        team { name }
                        ... on Human {
                            favorite_color
                            team {
                                aliased_field: name
                                description(short: true)
                            }
                        }
                        ...BotFrag
                    }

                    fragment BotFrag on Bot {
                        primary_function
                        team {
                            aliased_field: description(short: false)
                            num_users
                        }
                    }
                ',
                dict[],
                dict[
                    'one' => dict[
                        'team' => dict[
                            'name' => 'Test Team 1',
                            'aliased_field' => 'Test Team 1',
                            'description' => 'Short description',
                            'id' => 1,
                        ],
                        'favorite_color' => 'BLUE',
                    ],
                    'two' => dict[
                        'primary_function' => 'send spam',
                        'team' => dict[
                            'aliased_field' => 'Much longer description',
                            'num_users' => 3,
                            'name' => 'Test Team 1',
                            'id' => 1,
                        ],
                    ],
                ],
            ),
        ];
    }
}
