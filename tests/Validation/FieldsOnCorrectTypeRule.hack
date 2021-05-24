use namespace Slack\GraphQL\Validation;

final class FieldsOnCorrectTypeRuleTest extends BaseValidationTest {

    const classname<Validation\ValidationRule> RULE = Validation\FieldsOnCorrectTypeRule::class;

    public static function getTestCases(): this::TTestCases {
        return dict[
            'invalid interface field' => tuple(
                'query {
                    viewer {
                        favorite_color
                    }
                }',
                vec[shape(
                    'message' => 'Cannot query field "favorite_color" on type "User".',
                    'location' => shape('line' => 3, 'column' => 25),
                    'path' => vec['viewer'],
                )],
            ),
            'invalid object fields' => tuple(
                'query {
                    bot(id: 3) {
                        favorite_color
                    }
                    human(id: 3) {
                        primary_function
                    }
                }',
                vec[
                    shape(
                        'message' => 'Cannot query field "favorite_color" on type "Bot".',
                        'location' => shape('line' => 3, 'column' => 25),
                        'path' => vec['bot'],
                    ),
                    shape(
                        'message' => 'Cannot query field "primary_function" on type "Human".',
                        'location' => shape('line' => 6, 'column' => 25),
                        'path' => vec['human'],
                    ),
                ],
            ),
            'invalid nested object fields' => tuple(
                'query {
                    viewer {
                        team {
                            foo
                        }
                    }
                }',
                vec[shape(
                    'message' => 'Cannot query field "foo" on type "Team".',
                    'location' => shape('line' => 4, 'column' => 29),
                    'path' => vec['viewer', 'team'],
                )],
            ),
            'valid field' => tuple(
                'query {
                    viewer {
                        name
                    }
                }',
                vec[],
            ),
        ];
    }
}
