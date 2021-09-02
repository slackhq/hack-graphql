
use function Facebook\FBExpect\expect;

use namespace Slack\GraphQL;

final class FragmentTest extends PlaygroundTest {

    <<__Override>>
    public static function getTestCases(): this::TTestCases {
        return dict[
            'various interesting cases' => tuple(
                '
                    query {
                        one: user(id: 1) { ...BotFrag, ...UserFrag, team { id } }
                        two: bot(id: 2)  { ...BotFrag, ...UserFrag, team { id } }
                    }

                    fragment UserFrag on User {
                        team { name }
                        ... on Human {
                            favorite_color
                            team {
                                aliased_field: name
                                description(short: true)
                            }
                        }
                        ...BotFrag
                    }

                    fragment BotFrag on Bot {
                        primary_function
                        team {
                            aliased_field: description(short: false)
                            num_users
                        }
                    }
                ',
                dict[],
                dict[
                    'one' => dict[
                        'team' => dict[
                            'name' => 'Test Team 1',
                            'aliased_field' => 'Test Team 1',
                            'description' => 'Short description',
                            'id' => 1,
                        ],
                        'favorite_color' => 'BLUE',
                    ],
                    'two' => dict[
                        'primary_function' => 'send spam',
                        'team' => dict[
                            'aliased_field' => 'Much longer description',
                            'num_users' => 3,
                            'name' => 'Test Team 1',
                            'id' => 1,
                        ],
                    ],
                ],
            ),

            'directives' => tuple(
                'query (
                    $var_true: Boolean!
                    $var_false: Boolean!
                    $var_default_true: Boolean! = true
                    $var_default_false: Boolean! = false
                ) {
                    output_type_test {
                        a: scalar
                        b: scalar @skip(if: true)
                        c: scalar @skip(if: false)
                        d: scalar @include(if: true)
                        e: scalar @include(if: false)
                        f: scalar @skip(if: true)  @include(if: true)
                        g: scalar @skip(if: true)  @include(if: false)
                        h: scalar @skip(if: false) @include(if: true)
                        i: scalar @skip(if: false) @include(if: false)
                        j: scalar @include(if: true)  @skip(if: true)
                        k: scalar @include(if: false) @skip(if: true)
                        l: scalar @include(if: true)  @skip(if: false)
                        m: scalar @include(if: false) @skip(if: false)
                        n: scalar @skip(if: $var_true)
                        o: scalar @skip(if: $var_false)
                        p: scalar @include(if: $var_default_true)
                        q: scalar @include(if: $var_default_false)
                        r: scalar @skip(if: $var_default_false) @include(if: $var_true)
                        s: scalar @include(if: true) @skip(if: $var_default_true)
                        ...Frag @include(if: true)
                        ...Frag @skip(if: true)
                        ... @skip(if: false) {
                            w: scalar
                        }
                        ... @include(if: false) {
                            x: scalar
                        }
                        ... on OutputTypeTestObj @include(if: true) {
                            y: scalar
                        }
                        ... on OutputTypeTestObj @skip(if: true) {
                            z: scalar
                        }
                    }
                }

                fragment Frag on OutputTypeTestObj {
                    t: scalar
                    u: scalar @include(if: $var_true)
                    v: scalar @skip(if: true)
                }',
                dict['var_true' => true, 'var_false' => false],
                dict[
                    'output_type_test' => dict[
                        'a' => 42,
                        'c' => 42,
                        'd' => 42,
                        'h' => 42,
                        'l' => 42,
                        'o' => 42,
                        'p' => 42,
                        'r' => 42,
                        't' => 42,
                        'u' => 42,
                        'w' => 42,
                        'y' => 42,
                    ],
                ],
            ),
        ];
    }
}
