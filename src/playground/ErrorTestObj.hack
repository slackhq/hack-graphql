use namespace Slack\GraphQL;

<<GraphQL\ObjectType('ErrorTestObj', 'Test object for error handling')>>
final class ErrorTestObj {

    <<GraphQL\QueryRootField('error_test', 'Root field to get an instance')>>
    public static function get(): ErrorTestObj {
        return new self();
    }

    <<
        GraphQL\QueryRootField('error_test_nn', 'A non-nullable root field to get an instance'),
        GraphQL\KillsParentOnException,
    >>
    public static function getNonNullable(): ErrorTestObj {
        return new self();
    }

    <<GraphQL\Field('no_error', '')>>
    public function no_error(): int {
        return 42;
    }

    <<GraphQL\Field('user_facing_error', '')>>
    public function user_facing_error(): ?string {
        throw new GraphQL\UserFacingError('You shall not pass!');
    }

    <<GraphQL\Field(
        'hidden_exception',
        'Arbitrary exceptions are hidden from clients, since they might contain sensitive data',
    )>>
    public function hidden_exception(): int {
        // Contains a top secret IP address
        throw new \Exception('Could not connect to database at 127.0.0.1');
    }

    <<GraphQL\Field('non_nullable', ''), GraphQL\KillsParentOnException>>
    public function non_nullable(): int {
        throw new GraphQL\UserFacingError('You shall not pass!');
    }

    <<GraphQL\Field('nested', '')>>
    public function nested(): ErrorTestObj {
        return new self();
    }

    <<GraphQL\Field('nested_nn', ''), GraphQL\KillsParentOnException>>
    public function nested_nn(): ErrorTestObj {
        return new self();
    }

    /**
     * Lists with an invalid Int value.
     */
    <<GraphQL\Field('bad_int_list_n_of_n', '')>>
    public function bad_int_list_n_of_n(): vec<?int> {
        return $this->bad_int_list_nn_of_nn();
    }

    <<GraphQL\Field(
        'bad_int_list_n_of_nn',
        'Nullability of nested types is respected, which may result in killing the whole list (but no parents)',
    )>>
    public function bad_int_list_n_of_nn(): vec<int> {
        return $this->bad_int_list_nn_of_nn();
    }

    <<GraphQL\Field('bad_int_list_nn_of_nn', ''), GraphQL\KillsParentOnException>>
    public function bad_int_list_nn_of_nn(): vec<int> {
        return vec[1, 2, GraphQL\Types\IntType::MAX_SAFE_VALUE + 42, 3, 4];
    }

    /**
     * Lists of self. These may be killed by their non-nullable children.
     */
    <<GraphQL\Field('nested_list_n_of_n', '')>>
    public function nested_list_n_of_n(): vec<?ErrorTestObj> {
        return $this->nested_list_nn_of_nn();
    }

    <<GraphQL\Field('nested_list_n_of_nn', '')>>
    public function nested_list_n_of_nn(): vec<ErrorTestObj> {
        return $this->nested_list_nn_of_nn();
    }

    <<GraphQL\Field('nested_list_nn_of_nn', ''), GraphQL\KillsParentOnException>>
    public function nested_list_nn_of_nn(): vec<ErrorTestObj> {
        return vec[new self(), new self()];
    }
}
