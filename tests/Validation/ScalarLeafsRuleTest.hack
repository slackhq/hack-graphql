
use namespace Slack\GraphQL\Validation;

final class ScalarLeafsRuleTest extends BaseValidationTest {

    const classname<Validation\ValidationRule> RULE = Validation\ScalarLeafsRule::class;

    public static function getTestCases(): this::TTestCases {
        return dict[
            'selection on scalar' => tuple(
                'query {
                    viewer {
                        id {
                            foo
                        }
                    }
                }',
                vec[shape(
                    'message' => 'Field "id" must not have a selection since type "Int" has no subfields.',
                    'location' => shape('line' => 3, 'column' => 25),
                    'path' => vec['viewer', 'id'],
                )],
            ),
            'missing selection on nested scalar' => tuple(
                'query {
                    viewer {
                        team {
                            id {
                                foo
                            }
                        }
                    }
                }',
                vec[shape(
                    'message' => 'Field "id" must not have a selection since type "Int" has no subfields.',
                    'location' => shape('line' => 4, 'column' => 29),
                    'path' => vec['viewer', 'team', 'id'],
                )],
            ),
            'missing selection on composite' => tuple(
                'query {
                    viewer
                }',
                vec[shape(
                    'message' => 'Field "viewer" of type "User" must have a selection of subfields.',
                    'location' => shape('line' => 2, 'column' => 21),
                    'path' => vec['viewer'],
                )],
            ),
            'missing selection on nested composite' => tuple(
                'query {
                    viewer {
                        team
                    }
                }',
                vec[shape(
                    'message' => 'Field "team" of type "Team" must have a selection of subfields.',
                    'location' => shape('line' => 3, 'column' => 25),
                    'path' => vec['viewer', 'team'],
                )],
            ),
            'valid selection' => tuple(
                'query {
                    viewer {
                        id
                    }
                }',
                vec[],
            ),
        ];
    }
}
