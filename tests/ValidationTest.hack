use function Facebook\FBExpect\expect;
use namespace HH\Lib\{C, Vec};
use namespace Slack\GraphQL;


final class ValidationTest extends \Facebook\HackTest\HackTest {

    const type TTestCases = dict<string, (string, vec<string>)>;

    <<__Override>>
    public static async function beforeFirstTestAsync(): Awaitable<void> {
        await self::runCodegenAsync();
    }

    <<__Memoize>>
    private static async function runCodegenAsync(): Awaitable<void> {
        await GraphQL\Codegen\Generator::forPath(
            __DIR__.'/../src/playground',
            shape(
                'output_directory' => __DIR__.'/gen',
                'namespace' => 'Slack\GraphQL\Test\Generated',
            ),
        );
    }

    <<\Facebook\HackTest\DataProvider('getTestCases')>>
    final public async function test(string $query, vec<string> $expected_errors): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource($query);
        $parser = new \Graphpinator\Parser\Parser($source);
        $request = $parser->parse();

        $validator = new GraphQL\Validation\Validator(new \Slack\GraphQL\Test\Generated\Schema());
        $errors = $validator->validate($request);
        expect(Vec\map($errors, $error ==> $error->getMessage()))->toEqual($expected_errors);
    }

    public static function getTestCases(): this::TTestCases {
        return dict[
            'FieldsOnCorrectTypeRule: invalid interface field' => tuple(
                'query {
                    viewer {
                        favorite_color
                    }
                }',
                vec['Cannot query field "favorite_color" on type "User".'],
            ),
            'FieldsOnCorrectTypeRule: invalid object fields' => tuple(
                'query {
                    bot(id: 3) {
                        favorite_color
                    }
                    human(id: 3) {
                        primary_function
                    }
                }',
                vec[
                    'Cannot query field "favorite_color" on type "Bot".',
                    'Cannot query field "primary_function" on type "Human".',
                ],
            ),
            'FieldsOnCorrectTypeRule: valid field' => tuple(
                'query {
                    viewer {
                        name
                    }
                }',
                vec[],
            ),
            'ScalarLeafsRule: selection on scalar' => tuple(
                'query {
                    viewer {
                        id {
                            foo
                        }
                    }
                }',
                vec['Field "id" must not have a selection since type "Int" has no subfields.'],
            ),
            'ScalarLeafsRule: missing selection on composite' => tuple(
                'query {
                    viewer
                }',
                vec['Field "viewer" of type "User" must have a selection of subfields.'],
            ),
            'ScalarLeafsRule: valid selection' => tuple(
                'query {
                    viewer {
                        id
                    }
                }',
                vec[],
            ),
        ];
    }
}
