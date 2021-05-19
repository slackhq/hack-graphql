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
                        ],
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

            'non-nullable kills parent' => tuple(
                // Note: no_error resolves without errors but is thrown away with the parent.
                'query { error_test { non_nullable, no_error, hidden_exception } }',
                dict[],
                shape(
                    'data' => dict[
                        'error_test' => null,
                    ],
                    'errors' => vec[
                        shape(
                            'message' => 'You shall not pass!',
                            'path' => vec['error_test', 'non_nullable'],
                        ),
                        // Note: Error that would *NOT* have killed the parent is present, even though the field that
                        // raised this error was thrown away with its parent (i.e. when we throw away fields, we don't
                        // throw away any associated errors).
                        shape(
                            'message' => 'Caught exception while resolving field.',
                            'path' => vec['error_test', 'hidden_exception'],
                        ),
                    ],
                ),
            ),

            'nested nullable' => tuple(
                'query {
                    error_test {
                        nested { non_nullable, no_error, hidden_exception }
                        no_error
                    }
                }',
                dict[],
                shape(
                    'data' => dict[
                        'error_test' => dict[
                            'nested' => null,
                            'no_error' => 42,
                        ],
                    ],
                    'errors' => vec[
                        shape(
                            'message' => 'You shall not pass!',
                            'path' => vec['error_test', 'nested', 'non_nullable'],
                        ),
                        shape(
                            'message' => 'Caught exception while resolving field.',
                            'path' => vec['error_test', 'nested', 'hidden_exception'],
                        ),
                    ],
                ),
            ),

            'nested non-nullable' => tuple(
                'query {
                    error_test {
                        nested_nn { non_nullable, no_error, hidden_exception }
                        no_error
                    }
                }',
                dict[],
                shape(
                    'data' => dict[
                        'error_test' => null,
                    ],
                    'errors' => vec[
                        shape(
                            'message' => 'You shall not pass!',
                            'path' => vec['error_test', 'nested_nn', 'non_nullable'],
                        ),
                        shape(
                            'message' => 'Caught exception while resolving field.',
                            'path' => vec['error_test', 'nested_nn', 'hidden_exception'],
                        ),
                    ],
                ),
            ),

            'nested nullable lists' => tuple(
                'query {
                    error_test {
                        bad_int_list_n_of_n
                        bad_int_list_n_of_nn
                        nested_list_n_of_n { non_nullable, no_error, hidden_exception }
                        nested_list_n_of_nn { non_nullable, no_error }
                    }
                }',
                dict[],
                shape(
                    'data' => dict[
                        'error_test' => dict[
                            // 1 error here
                            'bad_int_list_n_of_n' => vec[1, 2, null, 3, 4],
                            // 1 error here
                            'bad_int_list_n_of_nn' => null,
                            // 4 errors here (2 per list item)
                            'nested_list_n_of_n' => vec[null, null],
                            // 2 errors here (1 per list item)
                            'nested_list_n_of_nn' => null,
                        ],
                    ],
                    'errors' => vec[
                        shape(
                            'message' => 'Integers must be in 32-bit range, got 2147483689',
                            'path' => vec['error_test', 'bad_int_list_n_of_n', 2],
                        ),
                        shape(
                            'message' => 'Integers must be in 32-bit range, got 2147483689',
                            'path' => vec['error_test', 'bad_int_list_n_of_nn', 2],
                        ),
                        shape(
                            'message' => 'You shall not pass!',
                            'path' => vec['error_test', 'nested_list_n_of_n', 0, 'non_nullable'],
                        ),
                        shape(
                            'message' => 'Caught exception while resolving field.',
                            'path' => vec['error_test', 'nested_list_n_of_n', 0, 'hidden_exception'],
                        ),
                        shape(
                            'message' => 'You shall not pass!',
                            'path' => vec['error_test', 'nested_list_n_of_n', 1, 'non_nullable'],
                        ),
                        shape(
                            'message' => 'Caught exception while resolving field.',
                            'path' => vec['error_test', 'nested_list_n_of_n', 1, 'hidden_exception'],
                        ),
                        shape(
                            'message' => 'You shall not pass!',
                            'path' => vec['error_test', 'nested_list_n_of_nn', 0, 'non_nullable'],
                        ),
                        shape(
                            'message' => 'You shall not pass!',
                            'path' => vec['error_test', 'nested_list_n_of_nn', 1, 'non_nullable'],
                        ),
                    ],
                ),
            ),

            'nested non-nullable lists' => tuple(
                'query {
                    a: error_test {
                        bad_int_list_nn_of_nn
                    }
                    b: error_test {
                        nested_list_nn_of_nn { non_nullable, no_error }
                    }
                }',
                dict[],
                shape(
                    'data' => dict[
                        'a' => null,
                        'b' => null,
                    ],
                    'errors' => vec[
                        shape(
                            'message' => 'Integers must be in 32-bit range, got 2147483689',
                            'path' => vec['a', 'bad_int_list_nn_of_nn', 2],
                        ),
                        shape(
                            'message' => 'You shall not pass!',
                            'path' => vec['b', 'nested_list_nn_of_nn', 0, 'non_nullable'],
                        ),
                        shape(
                            'message' => 'You shall not pass!',
                            'path' => vec['b', 'nested_list_nn_of_nn', 1, 'non_nullable'],
                        ),
                    ],
                ),
            ),

            'one deeply nested field kills the whole response, oops' => tuple(
                'query {
                    error_test_nn {
                        nested_list_nn_of_nn {
                            nested_nn {
                                non_nullable  # this is the one
                                no_error
                                hidden_exception
                            }
                            no_error
                        }
                        no_error
                        hidden_exception
                    }
                    error_test { no_error, hidden_exception }
                }',
                dict[],
                shape(
                    'data' => null,
                    'errors' => vec[
                        shape(
                            'message' => 'You shall not pass!',
                            'path' => vec['error_test_nn', 'nested_list_nn_of_nn', 0, 'nested_nn', 'non_nullable'],
                        ),
                        shape(
                            'message' => 'Caught exception while resolving field.',
                            'path' => vec['error_test_nn', 'nested_list_nn_of_nn', 0, 'nested_nn', 'hidden_exception'],
                        ),
                        shape(
                            'message' => 'You shall not pass!',
                            'path' => vec['error_test_nn', 'nested_list_nn_of_nn', 1, 'nested_nn', 'non_nullable'],
                        ),
                        shape(
                            'message' => 'Caught exception while resolving field.',
                            'path' => vec['error_test_nn', 'nested_list_nn_of_nn', 1, 'nested_nn', 'hidden_exception'],
                        ),
                        shape(
                            'message' => 'Caught exception while resolving field.',
                            'path' => vec['error_test_nn', 'hidden_exception'],
                        ),
                        shape(
                            'message' => 'Caught exception while resolving field.',
                            'path' => vec['error_test', 'hidden_exception'],
                        ),
                    ],
                ),
            ),

            'invalid enum values' => tuple(
                'query { takes_favorite_color(favorite_color: foo) }',
                dict[],
                shape(
                    'data' => dict[
                        'takes_favorite_color' => null,
                    ],
                    'errors' => vec[
                        shape(
                            'message' => 'Invalid value for "favorite_color": '.
                                'Expected a valid value for FavoriteColor, got "foo"',
                            'path' => vec['takes_favorite_color'],
                        ),
                    ],
                ),
            ),

            'invalid enum values with arguments' => tuple(
                'query { takes_favorite_color(favorite_color: $favorite_color) }',
                dict['favorite_color' => 'foo'],
                shape(
                    'data' => dict[
                        'takes_favorite_color' => null,
                    ],
                    'errors' => vec[
                        shape(
                            'message' => 'Caught exception while resolving field.',
                            'path' => vec['takes_favorite_color'],
                        ),
                    ],
                ),
            ),

            'missing variable' => tuple(
                'query ($id: Int!) { user(id: $id) { name } }',
                dict[],
                shape(
                    // Note: No 'data' because variable coercion errors happen before GraphQL execution starts.
                    'errors' => vec[
                        shape('message' => 'Missing value for required variable "id"'),
                    ],
                ),
            ),

            'invalid variable value' => tuple(
                'query ($id: Int!) { user(id: $id) { name } }',
                dict['id' => 'forty-two'],
                shape(
                    'errors' => vec[
                        shape('message' => 'Invalid value for variable "id": Expected an integer, got forty-two'),
                    ],
                ),
            ),

            'invalid variable default' => tuple(
                'query ($id: Int! = null) { user(id: $id) { name } }',
                dict[],
                shape(
                    'errors' => vec[
                        shape(
                            'message' => 'Invalid default value for variable "id": '.
                                'Expected an Int literal, got Graphpinator\\Parser\\Value\\NullLiteral',
                        ),
                    ],
                ),
            ),

            'invalid variable type' => tuple(
                'query ($id: InvalidType!) { user(id: $id) { name } }',
                dict[],
                shape(
                    'errors' => vec[
                        shape(
                            'message' => 'Unknown type "InvalidType".',
                            'location' => shape('line' => 1, 'column' => 13),
                        ),
                    ],
                ),
            ),

            'invalid selection on interface' => tuple(
                'query {
                    user(id: 2) {
                        id
                        name
                        favorite_color
                    }
                }',
                dict[],
                shape(
                    'errors' => vec[
                        shape(
                            'message' => 'Cannot query field "favorite_color" on type "User".',
                            'location' => shape('line' => 5, 'column' => 25),
                            'path' => vec['user'],
                        ),
                    ],
                ),
            ),

            'invalid selection on concrete type' => tuple(
                'query {
                    bot(id: 2) {
                        id
                        name
                        favorite_color
                    }
                }',
                dict[],
                shape(
                    'errors' => vec[
                        shape(
                            'message' => 'Cannot query field "favorite_color" on type "Bot".',
                            'location' => shape('line' => 5, 'column' => 25),
                            'path' => vec['bot'],
                        ),
                    ],
                ),
            ),

            'invalid query syntax' => tuple(
                'query ajjsdkadj',
                dict[],
                shape(
                    'errors' => vec[
                        shape(
                            'message' => 'Unexpected end of input. Probably missing closing brace?',
                            'location' => shape('line' => 1, 'column' => 7),
                        ),
                    ],
                ),
            ),
        ];
    }
}
