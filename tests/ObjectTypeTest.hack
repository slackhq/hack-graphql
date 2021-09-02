


use namespace Slack\GraphQL;

/**
 * Test GraphQL output objects.
 */
final class ObjectTypeTest extends PlaygroundTest {

    <<__Override>>
    public static function getTestCases(): this::TTestCases {
        return dict[
            'select an object generated from a shape' => tuple(
                'query {
                    getObjectShape {
                        foo
                        bar
                        baz {
                            abc
                        }
                    }
                }',
                dict[],
                dict[
                    'getObjectShape' => dict[
                        'foo' => 3,
                        'bar' => null,
                        'baz' => dict[
                            'abc' => vec[1, 2, 3],
                        ],
                    ],
                ],
            ),

            'select a nested shape only' => tuple(
                'query {
                    getObjectShape {
                        baz {
                            abc
                        }
                    }
                }',
                dict[],
                dict[
                    'getObjectShape' => dict[
                        'baz' => dict[
                            'abc' => vec[1, 2, 3],
                        ],
                    ],
                ],
            ),
        ];
    }
}
