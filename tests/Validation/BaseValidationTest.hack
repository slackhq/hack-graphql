


use function Facebook\FBExpect\expect;
use namespace HH\Lib\Vec;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Validation;

abstract class BaseValidationTest extends BaseTest {

    const type TTestCases = dict<string, (string, vec<GraphQL\UserFacingError::TData>)>;

    abstract const classname<Validation\ValidationRule> RULE;

    <<\Facebook\HackTest\DataProvider('getTestCases')>>
    final public async function test(string $query, vec<string> $expected_errors): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource($query);
        $parser = new \Graphpinator\Parser\Parser($source);
        $request = $parser->parse();

        $validator = new GraphQL\Validation\Validator(new GraphQL\Test\Generated\Schema());
        $validator->setRules(keyset[$this::RULE]);

        $errors = $validator->validate($request);
        expect(Vec\map($errors, $error ==> $error->toShape()))->toEqual($expected_errors);
    }
}
