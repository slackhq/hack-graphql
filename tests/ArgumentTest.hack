


use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;
use namespace Slack\GraphQL;

/**
* Test optional/nullable/required arguments with and without variables.
*/
final class ArgumentTest extends PlaygroundTest {
    <<__Override>>
    public static function getTestCases(): this::TTestCases {
        return dict[
            'all arguments' =>
                tuple('{ arg_test(required: 1, nullable: 2, optional: 3) }', dict[], dict['arg_test' => vec[1, 2, 3]]),

            'missing required' => tuple(
                '{ arg_test }',
                dict[],
                shape(
                    'data' => dict['arg_test' => null],
                    'errors' => vec[
                        shape(
                            'message' => 'Missing value for "required"',
                            'path' => vec['arg_test'],
                        ),
                    ],
                ),
            ),

            'required cannot be null' => tuple(
                '{ arg_test(required: null) }',
                dict[],
                shape(
                    'data' => dict['arg_test' => null],
                    'errors' => vec[
                        shape(
                            'message' => 'Invalid value for "required": '.
                                'Expected an Int literal, got Graphpinator\\Parser\\Value\\NullLiteral',
                            'path' => vec['arg_test'],
                        ),
                    ],
                ),
            ),

            'both optional and nullable can be omitted' =>
                tuple('{ arg_test(required: 69) }', dict[], dict['arg_test' => vec[69, null, 42]]),

            'override non-null default value with null' => tuple(
                '{ arg_test(required: 69, nullable: null, optional: null) }',
                dict[],
                dict['arg_test' => vec[69, null, null]],
            ),

            // variables

            'missing variable' => tuple(
                'query ($a: Int, $b: Int = null, $c: Int = 16) {
                    a: arg_test(required: 69, nullable: $a, optional: $a)
                    b: arg_test(required: 69, nullable: $b, optional: $b)
                    c: arg_test(required: 69, nullable: $c, optional: $c)
                }',
                dict[],
                dict[
                    // A missing variable without a default value doesn't override the argument's default value (42)...
                    'a' => vec[69, null, 42],
                    // ...but a missing variable with a default value (null or non-null) does.
                    'b' => vec[69, null, null],
                    'c' => vec[69, 16, 16],
                ],
            ),

            'null variable' => tuple(
                'query ($a: Int, $b: Int = null, $c: Int = 16) {
                    a: arg_test(required: 69, nullable: $a, optional: $a)
                    b: arg_test(required: 69, nullable: $b, optional: $b)
                    c: arg_test(required: 69, nullable: $c, optional: $c)
                }',
                dict['a' => null, 'b' => null, 'c' => null],
                dict[
                    'a' => vec[69, null, null],
                    'b' => vec[69, null, null],
                    'c' => vec[69, null, null],
                ],
            ),

            'non-null variable' => tuple(
                'query ($a: Int, $b: Int = null, $c: Int = 16) {
                    a: arg_test(required: 69, nullable: $a, optional: $a)
                    b: arg_test(required: 69, nullable: $b, optional: $b)
                    c: arg_test(required: 69, nullable: $c, optional: $c)
                }',
                dict['a' => 1, 'b' => 2, 'c' => 3],
                dict[
                    'a' => vec[69, 1, 1],
                    'b' => vec[69, 2, 2],
                    'c' => vec[69, 3, 3],
                ],
            ),

            // Non-list values can get promoted to a list if used where a list is expected.
            'list promotion' => tuple(
                'query ($var: [[[Int]]]) {
                    var:  list_arg_test(arg: $var)
                    nul:  list_arg_test(arg: null)
                    nul1: list_arg_test(arg: [null, null])
                    nul2: list_arg_test(arg: [[null], [null]])
                    nul3: list_arg_test(arg: [[null, null]])
                    num:  list_arg_test(arg: 42)
                    num1: list_arg_test(arg: [1, null, 2])
                    num2: list_arg_test(arg: [[1], null, [2], [null]])
                    num3: list_arg_test(arg: [[1, null, 2], null, 3])
                }',
                dict[], // $var is missing
                dict[
                    'var' => null,
                    'nul' => null, // no promotion if null is used in place of a nullable list...
                    'nul1' => vec[vec[null], vec[null]], // ...but null gets promoted when used for a non-nullable list
                    'nul2' => vec[vec[null], vec[null]], // different input, same output
                    'nul3' => vec[vec[null, null]], // no promotion
                    'num' => vec[vec[vec[42]]], // triple promotion
                    'num1' => vec[vec[vec[1]], vec[null], vec[vec[2]]], // double promotion
                    'num2' => vec[vec[vec[1]], vec[null], vec[vec[2]], vec[null]], // single promotion
                    'num3' => vec[vec[vec[1], null, vec[2]], vec[null], vec[vec[3]]], // single and double promotion
                ],
            ),
        ];
    }

}
