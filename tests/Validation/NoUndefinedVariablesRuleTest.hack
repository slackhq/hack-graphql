use namespace Slack\GraphQL\Validation;

final class NoUndefinedVariablesRuleTest extends BaseValidationTest {

    const classname<Validation\ValidationRule> RULE = Validation\NoUndefinedVariablesRule::class;

    public static function getTestCases(): this::TTestCases {
        return dict[
            'all variables defined' => tuple(
                '
                query Foo($a: String, $b: String, $c: String) {
                    field(a: $a, b: $b, c: $c)
                }
                ',
                vec[],
            ),
            'all variables deeply defined' => tuple(
                '
                query Foo($a: String, $b: String, $c: String) {
                    field(a: $a) {
                        field(b: $b) {
                            field(c: $c)
                        }
                    }
                }
                ',
                vec[],
            ),
            // TODO: Valid fragments
            'variables not defined' => tuple(
                '
                query Foo($a: String, $b: String, $c: String) {
                    field(a: $a, b: $b, c: $c, d: $d)
                }
                ',
                vec[
                    shape(
                        'message' => 'Variable "$d" is not defined by operation "Foo".',
                        'location' => shape('line' => 3, 'column' => 49),
                    ),
                ],
            ),
            'variables not defined in un-named query' => tuple(
                '
                {
                    field(a: $a)
                }
                ',
                vec[
                    shape(
                        'message' => 'Variable "$a" is not defined.',
                        'location' => shape('line' => 3, 'column' => 28),
                    ),
                ],
            ),
            'multiple variables not defined' => tuple(
                '
                query Foo($b: String) {
                    field(a: $a, b: $b, c: $c)
                }
                ',
                vec[
                    shape(
                        'message' => 'Variable "$a" is not defined by operation "Foo".',
                        'location' => shape('line' => 3, 'column' => 28),
                    ),
                    shape(
                        'message' => 'Variable "$c" is not defined by operation "Foo".',
                        'location' => shape('line' => 3, 'column' => 42),
                    ),
                ],
            ),
            // TODO: Invalid fragments
        ];
    }
}
