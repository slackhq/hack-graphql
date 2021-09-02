


namespace Graphpinator\Tests\Unit\Tokenizer;

use \Graphpinator\Tokenizer\Token;
use \Graphpinator\Tokenizer\TokenType;
use function Facebook\FBExpect\expect;

final class TokenizerTest extends \Facebook\HackTest\HackTest {
    public function simpleDataProvider(): vec<(string, vec<\Graphpinator\Tokenizer\Token>)> {
        return vec[
            tuple(
                '""',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::STRING, new \Graphpinator\Common\Location(1, 1), ''),
                ],
            ),
            tuple(
                '"ěščřžýá"',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        'ěščřžýá',
                    ),
                ],
            ),
            tuple(
                '"\\""',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::STRING, new \Graphpinator\Common\Location(1, 1), '"'),
                ],
            ),
            tuple(
                '"\\\\"',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::STRING, new \Graphpinator\Common\Location(1, 1), '\\'),
                ],
            ),
            tuple(
                '"\\/"',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::STRING, new \Graphpinator\Common\Location(1, 1), '/'),
                ],
            ),
            tuple(
                '"\\b"',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        "\u{0008}",
                    ),
                ],
            ),
            tuple(
                '"\\f"',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        "\u{000C}",
                    ),
                ],
            ),
            tuple(
                '"\\n"',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        "\u{000A}",
                    ),
                ],
            ),
            tuple(
                '"\\r"',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        "\u{000D}",
                    ),
                ],
            ),
            tuple(
                '"\\t"',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        "\u{0009}",
                    ),
                ],
            ),
            tuple(
                '"\\u1234"',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        "\u{1234}",
                    ),
                ],
            ),
            tuple(
                '"u1234"',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        'u1234',
                    ),
                ],
            ),
            tuple(
                '"abc\\u1234abc"',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        "abc\u{1234}abc",
                    ),
                ],
            ),
            tuple(
                '"blabla\\t\\"\\nfoobar"',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        "blabla\u{0009}\"\u{000A}foobar",
                    ),
                ],
            ),
            tuple(
                '""""""',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::STRING, new \Graphpinator\Common\Location(1, 1), ''),
                ],
            ),
            tuple(
                '""""""""',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::STRING, new \Graphpinator\Common\Location(1, 1), ''),
                    new \Graphpinator\Tokenizer\Token(TokenType::STRING, new \Graphpinator\Common\Location(1, 7), ''),
                ],
            ),
            tuple(
                '"""'.\PHP_EOL.'"""',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::STRING, new \Graphpinator\Common\Location(1, 1), ''),
                ],
            ),
            tuple(
                '"""   """',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::STRING, new \Graphpinator\Common\Location(1, 1), ''),
                ],
            ),
            tuple(
                '"""  abc  """',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        'abc  ',
                    ),
                ],
            ),
            tuple(
                '"""'.\PHP_EOL.\PHP_EOL.\PHP_EOL.'"""',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::STRING, new \Graphpinator\Common\Location(1, 1), ''),
                ],
            ),
            tuple(
                '"""'.\PHP_EOL.\PHP_EOL.'foo'.\PHP_EOL.\PHP_EOL.'"""',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        'foo',
                    ),
                ],
            ),
            tuple(
                '"""'.\PHP_EOL.\PHP_EOL.'       foo'.\PHP_EOL.\PHP_EOL.'"""',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        'foo',
                    ),
                ],
            ),
            tuple(
                '"""'.\PHP_EOL.' foo'.\PHP_EOL.'       foo'.\PHP_EOL.'"""',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        'foo'.\PHP_EOL.'      foo',
                    ),
                ],
            ),
            tuple(
                '"""   foo'.\PHP_EOL.\PHP_EOL.'  foo'.\PHP_EOL.\PHP_EOL.' foo"""',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        '  foo'.\PHP_EOL.\PHP_EOL.' foo'.\PHP_EOL.\PHP_EOL.'foo',
                    ),
                ],
            ),
            tuple(
                '"""\\n"""',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        "\\n",
                    ),
                ],
            ),
            tuple(
                '"""\\""""""',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        '"""',
                    ),
                ],
            ),
            tuple(
                '"""\\\\""""""',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        '\\"""',
                    ),
                ],
            ),
            tuple(
                '"""abc\\"""abc"""',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 1),
                        'abc"""abc',
                    ),
                ],
            ),
            tuple(
                '0',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::INT, new \Graphpinator\Common\Location(1, 1), '0'),
                ],
            ),
            tuple(
                '-0',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::INT, new \Graphpinator\Common\Location(1, 1), '-0'),
                ],
            ),
            tuple(
                '4',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::INT, new \Graphpinator\Common\Location(1, 1), '4'),
                ],
            ),
            tuple(
                '-4',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::INT, new \Graphpinator\Common\Location(1, 1), '-4'),
                ],
            ),
            tuple(
                '4.0',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::FLOAT, new \Graphpinator\Common\Location(1, 1), '4.0'),
                ],
            ),
            tuple(
                '-4.0',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::FLOAT,
                        new \Graphpinator\Common\Location(1, 1),
                        '-4.0',
                    ),
                ],
            ),
            tuple(
                '4e10',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::FLOAT,
                        new \Graphpinator\Common\Location(1, 1),
                        '4e10',
                    ),
                ],
            ),
            tuple(
                '4e0010',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::FLOAT,
                        new \Graphpinator\Common\Location(1, 1),
                        '4e0010',
                    ),
                ],
            ),
            tuple(
                '-4e10',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::FLOAT,
                        new \Graphpinator\Common\Location(1, 1),
                        '-4e10',
                    ),
                ],
            ),
            tuple(
                '4E10',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::FLOAT,
                        new \Graphpinator\Common\Location(1, 1),
                        '4e10',
                    ),
                ],
            ),
            tuple(
                '-4e-10',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::FLOAT,
                        new \Graphpinator\Common\Location(1, 1),
                        '-4e-10',
                    ),
                ],
            ),
            tuple(
                '4e+10',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::FLOAT,
                        new \Graphpinator\Common\Location(1, 1),
                        '4e10',
                    ),
                ],
            ),
            tuple(
                '-4e+10',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::FLOAT,
                        new \Graphpinator\Common\Location(1, 1),
                        '-4e10',
                    ),
                ],
            ),
            tuple(
                'null',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::NULL, new \Graphpinator\Common\Location(1, 1)),
                ],
            ),
            tuple(
                'NULL',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::NULL, new \Graphpinator\Common\Location(1, 1)),
                ],
            ),
            tuple(
                'Name',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::NAME, new \Graphpinator\Common\Location(1, 1), 'Name'),
                ],
            ),
            tuple(
                'NAME',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::NAME, new \Graphpinator\Common\Location(1, 1), 'NAME'),
                ],
            ),
            tuple(
                '__Name',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(1, 1),
                        '__Name',
                    ),
                ],
            ),
            tuple(
                'Name_with_underscore',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(1, 1),
                        'Name_with_underscore',
                    ),
                ],
            ),
            tuple(
                'FALSE true',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::FALSE, new \Graphpinator\Common\Location(1, 1)),
                    new \Graphpinator\Tokenizer\Token(TokenType::TRUE, new \Graphpinator\Common\Location(1, 7)),
                ],
            ),
            tuple(
                '... type fragment',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::ELLIP, new \Graphpinator\Common\Location(1, 1)),
                    new \Graphpinator\Tokenizer\Token(TokenType::NAME, new \Graphpinator\Common\Location(1, 5), 'type'),
                    new \Graphpinator\Tokenizer\Token(TokenType::FRAGMENT, new \Graphpinator\Common\Location(1, 10)),
                ],
            ),
            tuple(
                '-4.024E-10',
                vec[
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::FLOAT,
                        new \Graphpinator\Common\Location(1, 1),
                        '-4.024e-10',
                    ),
                ],
            ),
            tuple(
                'query { field1 { innerField } }',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::QUERY, new \Graphpinator\Common\Location(1, 1)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_O, new \Graphpinator\Common\Location(1, 7)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(1, 9),
                        'field1',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_O, new \Graphpinator\Common\Location(1, 16)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(1, 18),
                        'innerField',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_C, new \Graphpinator\Common\Location(1, 29)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_C, new \Graphpinator\Common\Location(1, 31)),
                ],
            ),
            tuple(
                'mutation { field(argName: 4) }',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::MUTATION, new \Graphpinator\Common\Location(1, 1)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_O, new \Graphpinator\Common\Location(1, 10)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(1, 12),
                        'field',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::PAR_O, new \Graphpinator\Common\Location(1, 17)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(1, 18),
                        'argName',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::COLON, new \Graphpinator\Common\Location(1, 25)),
                    new \Graphpinator\Tokenizer\Token(TokenType::INT, new \Graphpinator\Common\Location(1, 27), '4'),
                    new \Graphpinator\Tokenizer\Token(TokenType::PAR_C, new \Graphpinator\Common\Location(1, 28)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_C, new \Graphpinator\Common\Location(1, 30)),
                ],
            ),
            tuple(
                'subscription { field(argName: "str") }',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::SUBSCRIPTION, new \Graphpinator\Common\Location(1, 1)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_O, new \Graphpinator\Common\Location(1, 14)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(1, 16),
                        'field',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::PAR_O, new \Graphpinator\Common\Location(1, 21)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(1, 22),
                        'argName',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::COLON, new \Graphpinator\Common\Location(1, 29)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 31),
                        'str',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::PAR_C, new \Graphpinator\Common\Location(1, 36)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_C, new \Graphpinator\Common\Location(1, 38)),
                ],
            ),
            tuple(
                'query { field(argName: ["str", "str", $varName]) @directiveName }',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::QUERY, new \Graphpinator\Common\Location(1, 1)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_O, new \Graphpinator\Common\Location(1, 7)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(1, 9),
                        'field',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::PAR_O, new \Graphpinator\Common\Location(1, 14)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(1, 15),
                        'argName',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::COLON, new \Graphpinator\Common\Location(1, 22)),
                    new \Graphpinator\Tokenizer\Token(TokenType::SQU_O, new \Graphpinator\Common\Location(1, 24)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 25),
                        'str',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::COMMA, new \Graphpinator\Common\Location(1, 30)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 32),
                        'str',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::COMMA, new \Graphpinator\Common\Location(1, 37)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::VARIABLE,
                        new \Graphpinator\Common\Location(1, 39),
                        'varName',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::SQU_C, new \Graphpinator\Common\Location(1, 47)),
                    new \Graphpinator\Tokenizer\Token(TokenType::PAR_C, new \Graphpinator\Common\Location(1, 48)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::DIRECTIVE,
                        new \Graphpinator\Common\Location(1, 50),
                        'directiveName',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_C, new \Graphpinator\Common\Location(1, 65)),
                ],
            ),
            tuple(
                'query {'.\PHP_EOL.'field1 {'.\PHP_EOL.'innerField'.\PHP_EOL.'}'.\PHP_EOL.'}',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::QUERY, new \Graphpinator\Common\Location(1, 1)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_O, new \Graphpinator\Common\Location(1, 7)),
                    new \Graphpinator\Tokenizer\Token(TokenType::NEWLINE, new \Graphpinator\Common\Location(1, 8)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(2, 1),
                        'field1',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_O, new \Graphpinator\Common\Location(2, 8)),
                    new \Graphpinator\Tokenizer\Token(TokenType::NEWLINE, new \Graphpinator\Common\Location(2, 9)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(3, 1),
                        'innerField',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::NEWLINE, new \Graphpinator\Common\Location(3, 11)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_C, new \Graphpinator\Common\Location(4, 1)),
                    new \Graphpinator\Tokenizer\Token(TokenType::NEWLINE, new \Graphpinator\Common\Location(4, 2)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_C, new \Graphpinator\Common\Location(5, 1)),
                ],
            ),
            tuple(
                'query {'.
                \PHP_EOL.
                'field1 {'.
                \PHP_EOL.
                '# this is comment'.
                \PHP_EOL.
                'innerField'.
                \PHP_EOL.
                '}'.
                \PHP_EOL.
                '}',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::QUERY, new \Graphpinator\Common\Location(1, 1)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_O, new \Graphpinator\Common\Location(1, 7)),
                    new \Graphpinator\Tokenizer\Token(TokenType::NEWLINE, new \Graphpinator\Common\Location(1, 8)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(2, 1),
                        'field1',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_O, new \Graphpinator\Common\Location(2, 8)),
                    new \Graphpinator\Tokenizer\Token(TokenType::NEWLINE, new \Graphpinator\Common\Location(2, 9)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::COMMENT,
                        new \Graphpinator\Common\Location(3, 1),
                        ' this is comment',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::NEWLINE, new \Graphpinator\Common\Location(3, 18)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(4, 1),
                        'innerField',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::NEWLINE, new \Graphpinator\Common\Location(4, 11)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_C, new \Graphpinator\Common\Location(5, 1)),
                    new \Graphpinator\Tokenizer\Token(TokenType::NEWLINE, new \Graphpinator\Common\Location(5, 2)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_C, new \Graphpinator\Common\Location(6, 1)),
                ],
            ),
            tuple(
                'on',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::ON, new \Graphpinator\Common\Location(1, 1)),
                ],
            ),
            tuple(
                '&',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::AMP, new \Graphpinator\Common\Location(1, 1)),
                ],
            ),
            tuple(
                '|',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::PIPE, new \Graphpinator\Common\Location(1, 1)),
                ],
            ),
            tuple(
                '!',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::EXCL, new \Graphpinator\Common\Location(1, 1)),
                ],
            ),
            tuple(
                '=',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::EQUAL, new \Graphpinator\Common\Location(1, 1)),
                ],
            ),
        ];
    }

    /**
     * @dataProvider simpleDataProvider
     * @param string $source
     * @param array $tokens
     */
    <<\Facebook\HackTest\DataProvider('simpleDataProvider')>>
    public function testSimple(string $source, vec<\Graphpinator\Tokenizer\Token> $tokens): void {
        $source = new \Graphpinator\Source\StringSource($source);
        $tokenizer = new \Graphpinator\Tokenizer\Tokenizer($source, false);
        $index = 0;

        foreach ($tokenizer as $token) {
            expect($tokens[$index]->getType())->toBeSame($token?->getType());
            expect($tokens[$index]->getValue())->toBeSame($token?->getValue());
            expect($tokens[$index]->getLocation()->getLine())->toBeSame($token?->getLocation()?->getLine());
            expect($tokens[$index]->getLocation()->getColumn())->toBeSame($token?->getLocation()?->getColumn());
            ++$index;
        }
    }

    public function skipDataProvider(): vec<(string, vec<\Graphpinator\Tokenizer\Token>)> {
        return vec[
            tuple(
                'query { field(argName: ["str", "str", true, false, null]) }',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::QUERY, new \Graphpinator\Common\Location(1, 1)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_O, new \Graphpinator\Common\Location(1, 7)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(1, 9),
                        'field',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::PAR_O, new \Graphpinator\Common\Location(1, 14)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(1, 15),
                        'argName',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::COLON, new \Graphpinator\Common\Location(1, 22)),
                    new \Graphpinator\Tokenizer\Token(TokenType::SQU_O, new \Graphpinator\Common\Location(1, 24)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 25),
                        'str',
                    ),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::STRING,
                        new \Graphpinator\Common\Location(1, 32),
                        'str',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::TRUE, new \Graphpinator\Common\Location(1, 39)),
                    new \Graphpinator\Tokenizer\Token(TokenType::FALSE, new \Graphpinator\Common\Location(1, 45)),
                    new \Graphpinator\Tokenizer\Token(TokenType::NULL, new \Graphpinator\Common\Location(1, 52)),
                    new \Graphpinator\Tokenizer\Token(TokenType::SQU_C, new \Graphpinator\Common\Location(1, 56)),
                    new \Graphpinator\Tokenizer\Token(TokenType::PAR_C, new \Graphpinator\Common\Location(1, 57)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_C, new \Graphpinator\Common\Location(1, 59)),
                ],
            ),
            tuple(
                'query {'.\PHP_EOL.'field1 {'.\PHP_EOL.'innerField'.\PHP_EOL.'}'.\PHP_EOL.'}',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::QUERY, new \Graphpinator\Common\Location(1, 1)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_O, new \Graphpinator\Common\Location(1, 7)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(2, 1),
                        'field1',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_O, new \Graphpinator\Common\Location(2, 8)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(3, 1),
                        'innerField',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_C, new \Graphpinator\Common\Location(4, 1)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_C, new \Graphpinator\Common\Location(5, 1)),
                ],
            ),
            tuple(
                'query {'.
                \PHP_EOL.
                'field1 {'.
                \PHP_EOL.
                '# this is comment'.
                \PHP_EOL.
                'innerField'.
                \PHP_EOL.
                '}'.
                \PHP_EOL.
                '}',
                vec[
                    new \Graphpinator\Tokenizer\Token(TokenType::QUERY, new \Graphpinator\Common\Location(1, 1)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_O, new \Graphpinator\Common\Location(1, 7)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(2, 1),
                        'field1',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_O, new \Graphpinator\Common\Location(2, 8)),
                    new \Graphpinator\Tokenizer\Token(
                        TokenType::NAME,
                        new \Graphpinator\Common\Location(4, 1),
                        'innerField',
                    ),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_C, new \Graphpinator\Common\Location(5, 1)),
                    new \Graphpinator\Tokenizer\Token(TokenType::CUR_C, new \Graphpinator\Common\Location(6, 1)),
                ],
            ),
        ];
    }

    /**
     * @dataProvider skipDataProvider
     * @param string $source
     * @param array $tokens
     */
    <<\Facebook\HackTest\DataProvider('skipDataProvider')>>
    public function testSkip(string $source, vec<\Graphpinator\Tokenizer\Token> $tokens): void {
        $source = new \Graphpinator\Source\StringSource($source);
        $tokenizer = new \Graphpinator\Tokenizer\Tokenizer($source);
        $index = 0;

        foreach ($tokenizer as $token) {
            expect($tokens[$index]->getType())->toBeSame($token?->getType());
            expect($tokens[$index]->getValue())->toBeSame($token?->getValue());
            expect($tokens[$index]->getLocation()->getLine())->toBeSame($token?->getLocation()?->getLine());
            expect($tokens[$index]->getLocation()->getColumn())->toBeSame($token?->getLocation()?->getColumn());
            ++$index;
        }
    }

    public function invalidDataProvider(): vec<(string, classname<\Graphpinator\Exception\Tokenizer\TokenizerError>)> {
        return vec[
            tuple('"foo', \Graphpinator\Exception\Tokenizer\StringLiteralWithoutEnd::class),
            tuple('""""', \Graphpinator\Exception\Tokenizer\StringLiteralWithoutEnd::class),
            tuple('"""""', \Graphpinator\Exception\Tokenizer\StringLiteralWithoutEnd::class),
            tuple('"""""""', \Graphpinator\Exception\Tokenizer\StringLiteralWithoutEnd::class),
            tuple('"""\\""""', \Graphpinator\Exception\Tokenizer\StringLiteralWithoutEnd::class),
            tuple('"""abc""""', \Graphpinator\Exception\Tokenizer\StringLiteralWithoutEnd::class),
            tuple('"\\1"', \Graphpinator\Exception\Tokenizer\StringLiteralInvalidEscape::class),
            tuple('"\\u12z3"', \Graphpinator\Exception\Tokenizer\StringLiteralInvalidEscape::class),
            tuple('"\\u123"', \Graphpinator\Exception\Tokenizer\StringLiteralInvalidEscape::class),
            tuple('"'.\PHP_EOL.'"', \Graphpinator\Exception\Tokenizer\StringLiteralNewLine::class),
            tuple('123.-1', \Graphpinator\Exception\Tokenizer\NumericLiteralNegativeFraction::class),
            tuple('- 123', \Graphpinator\Exception\Tokenizer\NumericLiteralMalformed::class),
            tuple('123. ', \Graphpinator\Exception\Tokenizer\NumericLiteralMalformed::class),
            tuple('123.1e ', \Graphpinator\Exception\Tokenizer\NumericLiteralMalformed::class),
            tuple('00123', \Graphpinator\Exception\Tokenizer\NumericLiteralLeadingZero::class),
            tuple('00123.123', \Graphpinator\Exception\Tokenizer\NumericLiteralLeadingZero::class),
            tuple('123.1E ', \Graphpinator\Exception\Tokenizer\NumericLiteralMalformed::class),
            tuple('123e ', \Graphpinator\Exception\Tokenizer\NumericLiteralMalformed::class),
            tuple('123E ', \Graphpinator\Exception\Tokenizer\NumericLiteralMalformed::class),
            tuple('123Name', \Graphpinator\Exception\Tokenizer\NumericLiteralFollowedByName::class),
            tuple('123.123Name', \Graphpinator\Exception\Tokenizer\NumericLiteralFollowedByName::class),
            tuple('123.123eName', \Graphpinator\Exception\Tokenizer\NumericLiteralMalformed::class),
            tuple('-.E', \Graphpinator\Exception\Tokenizer\NumericLiteralMalformed::class),
            tuple('>>', \Graphpinator\Exception\Tokenizer\UnknownSymbol::class),
            tuple('123.45.67', \Graphpinator\Exception\Tokenizer\InvalidEllipsis::class),
            tuple('.E', \Graphpinator\Exception\Tokenizer\InvalidEllipsis::class),
            tuple('..', \Graphpinator\Exception\Tokenizer\InvalidEllipsis::class),
            tuple('....', \Graphpinator\Exception\Tokenizer\InvalidEllipsis::class),
            tuple('@ directiveName', \Graphpinator\Exception\Tokenizer\MissingDirectiveName::class),
            tuple('$ variableName', \Graphpinator\Exception\Tokenizer\MissingVariableName::class),
        ];
    }

    /**
     * @dataProvider invalidDataProvider
     * @param string $source
     * @param string $exception
     */
    <<\Facebook\HackTest\DataProvider('invalidDataProvider')>>
    public function testInvalid(
        string $source,
        classname<\Graphpinator\Exception\Tokenizer\TokenizerError> $exception,
    ): void {
        expect(() ==> {
            $source = new \Graphpinator\Source\StringSource($source);
            $tokenizer = new \Graphpinator\Tokenizer\Tokenizer($source);

            foreach ($tokenizer as $token) {
                expect($token)->toBeInstanceOf(Token::class);
            }
        })->toThrow($exception);
    }

    public function testSourceIndex(): void {
        $source = new \Graphpinator\Source\StringSource('query { "ěščřžýá" }');
        $tokenizer = new \Graphpinator\Tokenizer\Tokenizer($source);
        $indexes = vec[0, 6, 8, 18];
        $index = 0;

        foreach ($tokenizer as $key => $token) {
            expect($indexes[$index])->toBeSame($key);
            ++$index;
        }

        $index = 0;

        foreach ($tokenizer as $key => $token) {
            expect($indexes[$index])->toBeSame($key);
            ++$index;
        }
    }

    public function testBlockStringIndent(): void {
        $source1 = new \Graphpinator\Source\StringSource(
            '"""'.
            \PHP_EOL.
            '    Hello,'.
            \PHP_EOL.
            '      World!'.
            \PHP_EOL.
            \PHP_EOL.
            '    Yours,'.
            \PHP_EOL.
            '      GraphQL.'.
            \PHP_EOL.
            '"""',
        );
        $source2 = new \Graphpinator\Source\StringSource('"Hello,\\n  World!\\n\\nYours,\\n  GraphQL."');

        $tokenizer = new \Graphpinator\Tokenizer\Tokenizer($source1);
        $tokenizer->rewind();
        $token1 = $tokenizer->current() as nonnull;
        $tokenizer = new \Graphpinator\Tokenizer\Tokenizer($source2);
        $tokenizer->rewind();
        $token2 = $tokenizer->current() as nonnull;

        expect($token1->getType())->toBeSame($token2->getType());
        expect($token1->getValue())->toBeSame($token2->getValue());
    }

    public function testRewind(): void {
        $source = new \Graphpinator\Source\StringSource('Hello"World"');

        $tokenizer = new \Graphpinator\Tokenizer\Tokenizer($source, false);
        $tokenizer->rewind();
        expect('Hello')->toBeSame($tokenizer->current()?->getValue());
        $tokenizer->next();
        expect('World')->toBeSame($tokenizer->current()?->getValue());
        $tokenizer->rewind();
        expect('Hello')->toBeSame($tokenizer->current()?->getValue());
    }
}
