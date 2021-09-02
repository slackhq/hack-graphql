
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
                        __typename
                        also_typename: __typename  # test querying __typename with an alias
                        foo
                    }
                }',
                dict[],
                dict[
                    'getInterfaceA' => dict[
                        '__typename' => 'Concrete', // Note: __typename is always the resolved object type.
                        'also_typename' => 'Concrete',
                        'foo' => 'foo',
                    ],
                ],
            ),

            'select InterfaceB' => tuple(
                'query {
                    getInterfaceB {
                        __typename
                        foo
                        bar
                    }
                }',
                dict[],
                dict[
                    'getInterfaceB' => dict[
                        '__typename' => 'Concrete',
                        'foo' => 'foo',
                        'bar' => 'bar',
                    ],
                ],
            ),

            'select Concrete' => tuple(
                'query {
                    getConcrete {
                        __typename
                        foo
                        bar
                        baz
                    }
                }',
                dict[],
                dict[
                    'getConcrete' => dict[
                        '__typename' => 'Concrete',
                        'foo' => 'foo',
                        'bar' => 'bar',
                        'baz' => 'baz',
                    ],
                ],
            ),
        ];
    }
}
