


use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;
use namespace Slack\GraphQL;

final class DirectiveTest extends BaseTest {

    const type TExpectedResponse = shape(
        'field_resolutions' => dict<string, dict<string, dict<string, int>>>,
        'object_resolutions' => dict<string, dict<string, int>>,
    );

    const type TTestCases = dict<string, (string, dict<string, mixed>, this::TExpectedResponse)>;

    public static function getTestCases(): this::TTestCases {
        return dict[
            'runs the expected number of directives in the expected order' => tuple(
                'query {
                    human(id: 2) {
                        favorite_color
                    }
                }',
                dict[],
                shape(
                    'object_resolutions' => dict[
                        \Directives\AnotherDirective::class => dict[
                            'Human' => 1,
                        ],
                        \Directives\HasRole::class => dict[
                            'Human' => 1,
                        ],
                        \Directives\LogSampled::class => dict[
                            'Human' => 1,
                        ],
                    ],
                    'field_resolutions' => dict[
                        \Directives\AnotherDirective::class => dict[
                            'Human' => dict[
                                'favorite_color' => 1,
                            ],
                        ],
                        \Directives\HasRole::class => dict[
                            'Human' => dict[
                                'favorite_color' => 1,
                            ],
                        ],
                        \Directives\LogSampled::class => dict[
                            'Human' => dict[
                                'favorite_color' => 1,
                            ],
                        ],
                        \Directives\TestShapeDirective::class => dict[
                            'Human' => dict[
                                'favorite_color' => 1,
                            ],
                        ],
                    ],
                ),
            ),
            'runs directives for an interface' => tuple(
                'query {
                    viewer {
                        id
                    }
                }',
                dict[],
                shape(
                    'object_resolutions' => dict[
                        \Directives\AnotherDirective::class => dict[
                            'User' => 1,
                        ],
                    ],
                    'field_resolutions' => dict[],
                ),
            ),
        ];
    }

    public async function beforeEachTestAsync(): Awaitable<void> {
        DirectiveContext::reset();
    }

    <<\Facebook\HackTest\DataProvider('getTestCases')>>
    final public async function test(
        string $query,
        dict<string, mixed> $variables,
        this::TExpectedResponse $expected_response,
    ): Awaitable<void> {
        await $this->resolve($query, $variables);
        expect(DirectiveContext::$field_resolutions)->toEqual($expected_response['field_resolutions']);
        expect(DirectiveContext::$object_resolutions)->toEqual($expected_response['object_resolutions']);
    }
}
