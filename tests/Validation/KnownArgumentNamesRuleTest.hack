use namespace Slack\GraphQL;

final class KnownArgumentNamesRuleTest extends BaseValidationTest {
    public static function getTestCases(): this::TTestCases {
        return dict[
            'valid args' => tuple(
                'query {
                    viewer {
                        team {
                            description(short: true)
                        }
                    }
                }',
                vec[],
            ),
            'unknown arg' => tuple(
                'query {
                    viewer {
                        team {
                            description(unknown: true)
                        }
                    }
                }',
                vec[
                    shape(
                        'message' => 'Unknown argument "unknown" on field "Team.description".',
                        'location' => shape('line' => 4, 'column' => 41),
                        'path' => vec['viewer', 'team', 'description'],
                    ),
                ],
            ),
            'unknown arg amongst known args' => tuple(
                'query {
                    viewer {
                        team {
                            description(short: true, unknown: true)
                        }
                    }
                }',
                vec[
                    shape(
                        'message' => 'Unknown argument "unknown" on field "Team.description".',
                        'location' => shape('line' => 4, 'column' => 54),
                        'path' => vec['viewer', 'team', 'description'],
                    ),
                ],
            ),
            'unknown arg in mutation' => tuple(
                'mutation {
                    pokeUser(foo: 2) {
                        id
                    }
                }',
                vec[
                    shape(
                        'message' => 'Unknown argument "foo" on field "Mutation.pokeUser".',
                        'location' => shape('line' => 2, 'column' => 30),
                        'path' => vec['pokeUser'],
                    ),
                ],
            ),
        ];
    }
}
