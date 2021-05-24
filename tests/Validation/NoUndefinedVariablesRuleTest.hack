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
            'all variables deeply in inline fragments defined' => tuple(
                '
                query Foo($a: String, $b: String, $c: String) {
                    ... on Type {
                    field(a: $a) {
                        field(b: $b) {
                        ... on Type {
                            field(c: $c)
                        }
                        }
                    }
                    }
                }
                ',
                vec[],
            ),
            'all variables in fragments deeply defined' => tuple(
                '
                query Foo($a: String, $b: String, $c: String) {
                    ...FragA
                }
                fragment FragA on Type {
                    field(a: $a) {
                    ...FragB
                    }
                }
                fragment FragB on Type {
                    field(b: $b) {
                    ...FragC
                    }
                }
                fragment FragC on Type {
                    field(c: $c)
                }
                ',
                vec[],
            ),
            'variable within single fragment defined in multiple operations' => tuple(
                '
                query Foo($a: String) {
                    ...FragA
                }
                query Bar($a: String) {
                    ...FragA
                }
                fragment FragA on Type {
                    field(a: $a)
                }
                ',
                vec[],
            ),
            'variable within fragments defined in operations' => tuple(
                '
                query Foo($a: String) {
                    ...FragA
                }
                query Bar($b: String) {
                    ...FragB
                }
                fragment FragA on Type {
                    field(a: $a)
                }
                fragment FragB on Type {
                    field(b: $b)
                }
                ',
                vec[],
            ),
            'variable within recursive fragment definition' => tuple(
                '
                query Foo($a: String) {
                    ...FragA
                }
                fragment FragA on Type {
                    field(a: $a) {
                    ...FragA
                    }
                }
                ',
                vec[],
            ),
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
            'variable in fragment not defined by un-named query' => tuple(
                '
                {
                    ...FragA
                }
                fragment FragA on Type {
                    field(a: $a)
                }
                ',
                vec[
                    shape(
                        'message' => 'Variable "$a" is not defined.',
                        'location' => shape('line' => 6, 'column' => 28),
                    ),
                ],
            ),
            'variable in fragment not defined by operation' => tuple(
                '
                query Foo($a: String, $b: String) {
                    ...FragA
                }
                fragment FragA on Type {
                    field(a: $a) {
                        ...FragB
                    }
                }
                fragment FragB on Type {
                    field(b: $b) {
                        ...FragC
                    }
                }
                fragment FragC on Type {
                    field(c: $c)
                }
                ',
                vec[
                    shape(
                        'message' => 'Variable "$c" is not defined by operation "Foo".',
                        'location' => shape('line' => 16, 'column' => 28),
                    ),
                ],
            ),
            'multiple variables in fragments not defined' => tuple(
                '
                query Foo($b: String) {
                    ...FragA
                }
                fragment FragA on Type {
                    field(a: $a) {
                        ...FragB
                    }
                }
                fragment FragB on Type {
                    field(b: $b) {
                        ...FragC
                    }
                }
                fragment FragC on Type {
                    field(c: $c)
                }
                ',
                vec[
                    shape(
                        'message' => 'Variable "$a" is not defined by operation "Foo".',
                        'location' => shape('line' => 6, 'column' => 28),
                    ),
                    shape(
                        'message' => 'Variable "$c" is not defined by operation "Foo".',
                        'location' => shape('line' => 16, 'column' => 28),
                    ),
                ],
            ),
            'single variable in fragment not defined by multiple operations' => tuple(
                '
                query Foo($a: String) {
                    ...FragAB
                }
                query Bar($a: String) {
                    ...FragAB
                }
                fragment FragAB on Type {
                    field(a: $a, b: $b)
                }
                ',
                vec[
                    shape(
                        'message' => 'Variable "$b" is not defined by operation "Foo".',
                        'location' => shape('line' => 9, 'column' => 35),
                    ),
                    shape(
                        'message' => 'Variable "$b" is not defined by operation "Bar".',
                        'location' => shape('line' => 9, 'column' => 35),
                    ),
                ],
            ),
            'variables in fragment not defined by multiple operations' => tuple(
                '
                query Foo($b: String) {
                    ...FragAB
                }
                query Bar($a: String) {
                    ...FragAB
                }
                fragment FragAB on Type {
                    field(a: $a, b: $b)
                }
                ',
                vec[
                    shape(
                        'message' => 'Variable "$a" is not defined by operation "Foo".',
                        'location' => shape('line' => 9, 'column' => 28),
                    ),
                    shape(
                        'message' => 'Variable "$b" is not defined by operation "Bar".',
                        'location' => shape('line' => 9, 'column' => 35),
                    ),
                ],
            ),
            'variable in fragment used by other operation' => tuple(
                '
                query Foo($b: String) {
                    ...FragA
                }
                query Bar($a: String) {
                    ...FragB
                }
                fragment FragA on Type {
                    field(a: $a)
                }
                fragment FragB on Type {
                    field(b: $b)
                }
                ',
                vec[
                    shape(
                        'message' => 'Variable "$a" is not defined by operation "Foo".',
                        'location' => shape('line' => 9, 'column' => 28),
                    ),
                    shape(
                        'message' => 'Variable "$b" is not defined by operation "Bar".',
                        'location' => shape('line' => 12, 'column' => 28),
                    ),
                ],
            ),
            'multiple undefined variables produce multiple errors' => tuple(
                '
                query Foo($b: String) {
                    ...FragAB
                }
                query Bar($a: String) {
                    ...FragAB
                }
                fragment FragAB on Type { 
                    field1(a: $a, b: $b)
                    ...FragC
                    field3(a: $a, b: $b)
                }
                fragment FragC on Type {
                    field2(c: $c)
                }
                ',
                vec[
                    shape(
                        'message' => 'Variable "$a" is not defined by operation "Foo".',
                        'location' => shape('line' => 9, 'column' => 29),
                    ),
                    shape(
                        'message' => 'Variable "$a" is not defined by operation "Foo".',
                        'location' => shape('line' => 11, 'column' => 29),
                    ),
                    shape(
                        'message' => 'Variable "$c" is not defined by operation "Foo".',
                        'location' => shape('line' => 14, 'column' => 29),
                    ),
                    shape(
                        'message' => 'Variable "$b" is not defined by operation "Bar".',
                        'location' => shape('line' => 9, 'column' => 36),
                    ),
                    shape(
                        'message' => 'Variable "$b" is not defined by operation "Bar".',
                        'location' => shape('line' => 11, 'column' => 36),
                    ),
                    shape(
                        'message' => 'Variable "$c" is not defined by operation "Bar".',
                        'location' => shape('line' => 14, 'column' => 29),
                    ),
                ],
            ),
        ];
    }
}
