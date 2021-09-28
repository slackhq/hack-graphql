


use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;
use namespace Slack\GraphQL;

abstract class FixtureTest extends BaseTest {

    const type TTestCases = dict<string, (string, dict<string, mixed>, mixed)>;

    <<\Facebook\HackTest\DataProvider('getTestCases')>>
    final public async function test(
        string $query,
        dict<string, mixed> $variables,
        mixed $expected_response,
    ): Awaitable<void> {
        // If $expected_response is not a shape with 'data' and/or 'errors', assume it's the data.
        if (
            !$expected_response is shape('data' => mixed, ...) && !$expected_response is shape('errors' => mixed, ...)
        ) {
            $expected_response = shape('data' => $expected_response);
        }

        $out = await $this->resolve($query, $variables);
        expect($out)->toHaveSameShapeAs($expected_response);
    }
}
