


use namespace Slack\GraphQL;

abstract final class ArgumentTestObj {

    <<GraphQL\QueryRootField('arg_test', 'Root field for testing arguments')>>
    public static function argTest(int $required, ?int $nullable, ?int $optional = 42): vec<?int> {
        return vec[$required, $nullable, $optional];
    }

    <<GraphQL\QueryRootField('list_arg_test', 'Root field for testing list arguments')>>
    public static function listArgTest(?vec<vec<?vec<int>>> $arg): ?vec<?vec<?vec<int>>> {
        return $arg;
    }
}
