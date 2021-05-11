use namespace Slack\GraphQL;

<<GraphQL\ObjectType('ErrorTest', 'Test object for error handling')>>
final class ErrorTestObj {

    <<GraphQL\QueryRootField('error_test', 'Root field to get an instance')>>
    public static function get(): ErrorTestObj {
        return new self();
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
}
