


use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;
use namespace Slack\GraphQL;

/**
 * Test GraphQL fields with various types.
 */
final class OutputTypeTest extends FixtureTest {

    <<__Override>>
    public static function getTestCases(): this::TTestCases {
        return dict[
            'all OutputTypeTestObj fields' => tuple(
                'query {
                    output_type_test {
                        scalar
                        nullable
                        awaitable
                        awaitable_nullable
                        list
                        awaitable_nullable_list
                        nested_lists
                        output_shape {
                            string
                            vec_of_int
                            nested_shape {
                                vec_of_string
                            }
                        }
                    }
                }',
                dict[],
                dict[
                    'output_type_test' => dict[
                        'scalar' => 42,
                        'nullable' => null,
                        'awaitable' => 42,
                        'awaitable_nullable' => null,
                        'list' => vec['forty', 'two'],
                        'awaitable_nullable_list' => null,
                        'nested_lists' => vec[
                            vec[vec[null, 42]],
                            null,
                            vec[vec[42], vec[null]],
                        ],
                        'output_shape' => dict[
                            'string' => 'test',
                            'vec_of_int' => vec[1, 2, 3],
                            'nested_shape' => dict[
                                'vec_of_string' => vec['test', 'strings'],
                            ],
                        ],
                    ],
                ],
            ),
        ];
    }
}
