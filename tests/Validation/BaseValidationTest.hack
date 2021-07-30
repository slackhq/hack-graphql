


use function Facebook\FBExpect\expect;
use namespace HH\Lib\{C, Vec};
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Validation;

abstract class BaseValidationTest extends \Facebook\HackTest\HackTest {

    const type TTestCases = dict<string, (string, vec<GraphQL\UserFacingError::TData>)>;

    abstract const classname<Validation\ValidationRule> RULE;

    <<__Override>>
    public static async function beforeFirstTestAsync(): Awaitable<void> {
        await self::runCodegenAsync();
    }

    <<__Memoize>>
    private static async function runCodegenAsync(): Awaitable<void> {
        await GraphQL\Codegen\Generator::forPath(
            __DIR__.'/../Fixtures',
            shape(
                'output_directory' => __DIR__.'/../gen',
                'namespace' => 'Slack\GraphQL\Test\Generated',
            ),
        );
    }

    <<\Facebook\HackTest\DataProvider('getTestCases')>>
    final public async function test(string $input, vec<string> $expected_errors): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource($input);
        $parser = new \Graphpinator\Parser\Parser($source);
        $query = $parser->parse();
        $operation = C\firstx($query->getOperations());

        $request = new GraphQL\WellformedRequest($input, dict[], $query, $operation);

        $validator = new GraphQL\Validation\Validator(new \Slack\GraphQL\Test\Generated\Schema());
        $validator->setRules(keyset[$this::RULE]);

        $errors = $validator->validate($request);
        expect(Vec\map($errors, $error ==> $error->toShape()))->toEqual($expected_errors);
    }
}
