namespace Graphpinator\Tests\Unit\Source;

use function Facebook\FBExpect\expect;

final class SourceTest extends \Facebook\HackTest\HackTest {
    public function simpleDataProvider(): vec<(string, vec<string>)> {
        return vec[
            tuple('987123456', vec['9', '8', '7', '1', '2', '3', '4', '5', '6']),
            tuple('věýéšč$aa', vec['v', 'ě', 'ý', 'é', 'š', 'č', '$', 'a', 'a']),
            tuple('⺴⻕⻨⺮', vec['⺴', '⻕', '⻨', '⺮']),
        ];
    }

    /**
     * @dataProvider simpleDataProvider
     * @param string $source
     * @param array $chars
     */
    <<\Facebook\HackTest\DataProvider('simpleDataProvider')>>
    public function testSimple(string $source, vec<mixed> $chars): void {
        $source = new \Graphpinator\Source\StringSource($source);

        expect(\count($chars))->toBeSame($source->getNumberOfChars());

        $index = 0;

        foreach ($source as $key => $val) {
            expect($index)->toBeSame($key);
            expect($chars[$index])->toBeSame($val);

            ++$index;
        }
    }

    /**
     * @dataProvider simpleDataProvider
     * @param string $source
     */
    <<\Facebook\HackTest\DataProvider('simpleDataProvider')>>
    public function testInitialization(string $source): void {
        $source = new \Graphpinator\Source\StringSource($source);

        expect($source->valid())->toBeTrue();
        expect(0)->toBeSame($source->key());
    }

    public function testInvalid(): void {
        expect(() ==> {
            $source = new \Graphpinator\Source\StringSource('123');

            $source->next();
            $source->next();
            $source->next();
            $source->getChar();
        })->toThrow(
            \Graphpinator\Exception\Tokenizer\SourceUnexpectedEnd::class,
            'Unexpected end of input. Probably missing closing brace?',
        );
    }

    public function testLocation(): void {
        $source = new \Graphpinator\Source\StringSource('abcd'.\PHP_EOL.'abcde'.\PHP_EOL.\PHP_EOL.\PHP_EOL.'abc');
        $lines = dict[1 => 5, 2 => 6, 3 => 1, 4 => 1, 5 => 3];

        for ($line = 1; $line <= 5; ++$line) {
            for ($column = 1; $column <= $lines[$line]; ++$column) {
                $location = $source->getLocation();

                expect($line)->toBeSame($location->getLine());
                expect($column)->toBeSame($location->getColumn());

                $source->next();
            }
        }
    }
}
