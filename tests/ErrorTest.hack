use function Facebook\FBExpect\expect;

final class ErrorTest extends PlaygroundTest {

    <<__Override>>
    public static function getTestCases(): this::TTestCases {
        return dict[
            'errors' => tuple(
                'query { error_test { user_facing_error, hidden_exception } }',
                dict[],
                shape(
                    'data' => dict[
                        'error_test' => dict[
                            'user_facing_error' => null,
                            'hidden_exception' => null,
                        ]
                    ],
                    'errors' => vec[
                        shape(
                            'message' => 'You shall not pass!',
                            'path' => vec['error_test', 'user_facing_error'],
                        ),
                        shape(
                            'message' => 'Caught exception while resolving field.',
                            'path' => vec['error_test', 'hidden_exception'],
                        ),
                    ],
                ),
            ),
        ];
    }
}
