use namespace Slack\GraphQL;

/**
 * Test GraphQL interfaces.
 */
final class InterfaceTypeTest extends PlaygroundTest {

    <<__Override>>
    public static function getTestCases(): this::TTestCases {
        return dict[
            'select InterfaceA' => tuple(
                'query {
                    getInterfaceA {
                        foo
                    }
                }',
                dict[],
                dict[
                    'getInterfaceA' => dict[
                        'foo' => 'foo',
                    ],
                ],
            ),

            'select InterfaceB' => tuple(
                'query {
                    getInterfaceB {
                        foo
                        bar
                    }
                }',
                dict[],
                dict[
                    'getInterfaceB' => dict[
                        'foo' => 'foo',
                        'bar' => 'bar',
                    ],
                ],
            ),

            'select Concrete' => tuple(
                'query {
                    getConcrete {
                        foo
                        bar
                        baz
                    }
                }',
                dict[],
                dict[
                    'getConcrete' => dict[
                        'foo' => 'foo',
                        'bar' => 'bar',
                        'baz' => 'baz',
                    ],
                ],
            ),
        ];
    }
}
