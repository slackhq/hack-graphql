use namespace Slack\GraphQL;

use namespace HH\Lib\C;
use function Facebook\FBExpect\expect;

final class IntrospectionTest extends PlaygroundTest {

    <<__Override>>
    public static function getTestCases(): this::TTestCases {
        return dict[
            'select the name of the query type' => tuple(
                '{
                    __schema {
                        queryType {
                            kind
                            name
                        }
                    }

                    __type(name: "Query") {
                        kind
                        name
                    }
                }',
                dict[],
                dict[
                    '__schema' => dict[
                        'queryType' => dict[
                            'kind' => 'OBJECT',
                            'name' => 'Query',
                        ],
                    ],
                    '__type' => dict[
                        'kind' => 'OBJECT',
                        'name' => 'Query',
                    ],
                ],
            ),
        ];
    }

    public async function testSchemaTypes(): Awaitable<void> {
        $out = await $this->resolve(
            '{
                __schema {
                    types {
                        kind
                        name
                    }
                }
             }',
        );
        expect(C\count((($out['data'] ?? null) as dynamic)['__schema']['types'] as Container<_>))->toBeGreaterThan(
            2,
            'we have at least two types Query + Mutation',
        );
    }
}
